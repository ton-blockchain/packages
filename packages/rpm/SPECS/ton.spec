Name:           ton
Version:        dev
Release:        %{releasever}
Summary:        The Open Network

License:        LGPLv2
Source0:        ton.tar.gz

%global __os_install_post %{_usr}/lib/rpm/brp-compress %{nil} # disable brp-strip

%description
A collection of The Open Network core software and utilities.

%prep
%autosetup -c
%setup -q

%build

%install
mkdir -p %{buildroot}/%{_bindir} %{buildroot}/%{_libdir} %{buildroot}/%{_datadir}

cp -ar bin/* %{buildroot}/%{_bindir}
cp -ar lib/* %{buildroot}/%{_libdir}
cp -ar share/* %{buildroot}/%{_datadir}

%files
%{_bindir}/*
%{_libdir}/*
%{_datadir}/*
