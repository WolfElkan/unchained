echo "Please enter a Project name:"
read project_name
echo "Please enter an app name\n[main]"
read app_name
if [[ "$app_name" = "" ]]; then
	app_name="main"
fi
# Replace this with the absolute path to wherever you have Django installed
source ~/Desktop/PYTHON/myEnvironments/djangoEnv/bin/activate
django-admin startproject $project_name
cd $project_name
mkdir apps
cd apps
touch __init__.py
python ../manage.py startapp $app_name
cd $app_name
touch urls.py
echo "from django.conf.urls import url" >> urls.py
echo "from . import views" >> urls.py
echo "urlpatterns = [\n\turl(r'^$', views.index),\n]" >> urls.py
echo "\ndef index(request):\n\tcontext = {}\n\treturn render(request, \"$app_name/index.html\", context)" >> views.py
mkdir templates
cd templates
mkdir $app_name
cd $app_name
touch index.html
echo "<!DOCTYPE html>\n<html>\n\t<head>\n\t\t<title>$project_name</title>\n\t\t<meta charset=\"utf-8\">\n\t</head>\n\t<body>\n\t\t<h1>views#index</h1>\n\t\t<p>Find me in $project_name/apps/$app_name/templates/$app_name/index.html</p>\n\t</body>\n</html>" >> index.html
cd ../../../../$project_name
echo "INSTALLED_APPS += ['apps.$app_name']" >> settings.py
echo "from django.conf.urls import include" >> urls.py
echo "urlpatterns = [ url(r'^', include('apps.$app_name.urls')) ]" >> urls.py

echo "source ~/Desktop/Education/CodingDojo/PYTHON/myEnvironments/djangoEnv/bin/activate"
echo "cd $project_name"