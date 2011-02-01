
Name:		gitslave
Summary:	gitslave creates a group of related repositories
Group:		Development/Other
Version:	1.2
Release:	%mkrel 1
License:	LGPL 2.1
URL:		http://gitslave.sourceforge.net
Source0:	http://downloads.sourceforge.net/project/gitslave/%{name}-%{version}.tar.gz
BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-buildroot
Requires:	perl
BuildArch:	noarch

%description
gitslave creates a group of related repositories—a superproject repository and
a number of slave repositories—all of which are concurrently developed on and
on which all git operations should normally operate; so when you branch, each
repository in the project is branched in turn.

%files
%defattr(-,root,root)
%_bindir
%_mandir


#---------------------------------------------------------------------------------
%prep
%setup -q

%build
sed -i 's#/local##g' Makefile
%make

%install
rm -rf %buildroot
%makeinstall_std

%clean
rm -rf %buildroot


%changelog
* Tue Feb 01 2011 Zé <ze@mandriva.org> 2.6.50-1mde2010.2
- first release