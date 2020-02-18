gitlab_config="$(cat ~/.config/gitlab_config)"

access_token="$(echo $gitlab_config | jq -r '.access_token')"
username="$(echo $gitlab_config | jq -r '.username')"
gitlab_url="$(echo $gitlab_config | jq -r '.gitlab_url')"

if [ -z "$username" ] || [ -z "$gitlab_url" ];
then
    exit 0
fi
date_before_yesterday="$(date -d '-2 day' '+%Y-%m-%d')"

projects_pushed_to=$(curl --silent --header "PRIVATE-TOKEN: $access_token" "https://$gitlab_url/api/v4/users/$username/events?action=pushed&after=$date_before_yesterday")

if [ "$projects_pushed_to" = "[]" ]
then
    echo ""
    exit 0
fi

project_id="$(echo $projects_pushed_to| jq '.[0].project_id')"
project_name=$(curl --silent --header "PRIVATE-TOKEN: $access_token" "https://$gitlab_url/api/v4/projects/$project_id" | jq '.name' | sed 's/"//g')
latest_pipeline=$(curl --silent --header "PRIVATE-TOKEN: $access_token" "https://$gitlab_url/api/v4/projects/$project_id/pipelines?username=$username&order_by=updated_at&sort=desc" | jq '.[0]')

pipeline_id="$(echo $latest_pipeline | jq '.id')"
status="$(echo "$latest_pipeline" | jq -r '.status')"
status_icon=''

if [ "$status" = 'success' ]
then
    status_icon='%{T5}%{T-}'

elif [ "$status" = 'failed' ]
then
    status_icon='%{T5}ﮢ%{T-}'

elif [ "$status" = 'running' ]
then
    status_icon='%{T5}%{T-}'

elif [ "$status" = 'pending' ]
then
    status_icon='%{T5}%{T-}'

elif [ "$status" = 'canceled' ]
then
    status_icon='%{T5}%{T-}'

elif [ "$status" = 'skipped' ]
then
    status_icon='%{T5}%{T-}'
fi

updated_at="$(echo $latest_pipeline | jq -r '.updated_at')"

if [ "$(date -d $updated_at +%s)" -lt "$(date -d '-20 min' +%s )" ] \
    && ([ "$status" != 'running' ] || [ "$status" != 'pending' ])
then
    exit 0
fi

gitlab_icon='%{T5}ﭼ%{T-}'

echo "$gitlab_icon $project_name #$pipeline_id $status_icon"
