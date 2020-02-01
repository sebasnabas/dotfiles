access_token="$(cat ~/.config/gitlab-access-token)"
username='sebasnabas'
date_before_yesterday="$(date -d '-2 day' '+%Y-%m-%d')"

project_id=$(curl --silent --header "PRIVATE-TOKEN: $access_token" "https://gitlab.com/api/v4/users/$username/events?action=pushed&after=$date_before_yesterday" | jq '.[0].project_id')
project_name=$(curl --silent --header "PRIVATE-TOKEN: $access_token" "https://gitlab.com/api/v4/projects/$project_id" | jq '.name' | sed 's/"//g')
latest_pipeline=$(curl --silent --header "PRIVATE-TOKEN: $access_token" "https://gitlab.com/api/v4/projects/$project_id/pipelines?username=$username&order_by=updated_at&sort=desc" | jq '.[0]')

pipeline_id="$(echo $latest_pipeline | jq '.id' | head --bytes 5 )~"
status="$(echo "$latest_pipeline" | jq '.status' | sed 's/\"//g')"
status_icon=''

if [ "$status" = 'success' ]
then
    status_icon='%{T8}%{T-}'

elif [ "$status" = 'failed' ]
then
    status_icon='%{T8}ﮢ%{T-}'

elif [ "$status" = 'running' ]
then
    status_icon='%{T8}%{T-}'

elif [ "$status" = 'pending' ]
then
    status_icon='%{T8}%{T-}'

elif [ "$status" = 'canceled' ]
then
    status_icon='%{T8}%{T-}'

elif [ "$status" = 'skipped' ]
then
    status_icon='%{T8}%{T-}'
fi

gitlab_icon='%{T8}ﭼ%{T-}'
updated_at="$(echo $latest_pipeline | jq '.updated_at' | sed 's/\"//g')"

if [ "$(date -d $updated_at +%s)" -lt "$(date -d '-10 min' +%s )" ] \
    && ([ "$status" != 'running' ] || [ "$status" != 'pending' ])
then
    exit 0
fi

echo "$gitlab_icon $project_name #$pipeline_id $status_icon"
