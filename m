Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70E444B1FE
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Nov 2021 18:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240407AbhKIRby (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Nov 2021 12:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234677AbhKIRbx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 9 Nov 2021 12:31:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 994566117A;
        Tue,  9 Nov 2021 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636478947;
        bh=vRdTn1I/sGttz8FW/LF/iULOXTjQjcbH1pNpnnH9NC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MaYbrjtsWoWx9jHkpDSOzyVgF5WReg+xLsluTrdLp0TAFfyJqD7/9fZp6pJYTlfMK
         pRvZf8BETLjC8as8+Vnk7x8MaFItdMaYDw/vAh5Na9qa/2J7dAXG9yxst4ftfQruTS
         6DiU8IVzjcBfU627uvnRhrw1M08yl03YBlWi4ho1eyU1thgtZIuZhkEnVbxqnHTXbO
         cmVQwwCRgq5aqO+ZHy3O+LPrOhWkXMfRpWgefPP0M3FxNXp1xBR60tTWpSutd6RrG2
         vcAIy0TpoiN1G8AuZMsDAaTeeH4alxYgLDAX9zW3Q7kGQrFywGQHOyhGF7wD2cXNIy
         fuwcrr23fndNA==
Date:   Tue, 9 Nov 2021 09:29:07 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH v2 1/2] common/rc: add _require_kernel_config and
 _has_kernel_config
Message-ID: <20211109172907.GM24282@magnolia>
References: <20211108151916.27845-1-lczerner@redhat.com>
 <20211108210423.28980-1-lczerner@redhat.com>
 <20211108223132.GB24255@magnolia>
 <20211109090855.n3nceaez73laqvze@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211109090855.n3nceaez73laqvze@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 09, 2021 at 10:28:43AM +0100, Lukas Czerner wrote:
> On Mon, Nov 08, 2021 at 02:31:32PM -0800, Darrick J. Wong wrote:
> > On Mon, Nov 08, 2021 at 10:04:23PM +0100, Lukas Czerner wrote:
> > > Add _require_kernel_config() and _has_kernel_config() helpers to check
> > > whether a specific kernel configuration is enabled on the kernel.
> > > 
> > > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > > ---
> > > v2: Document KCONFIG_PATH in README
> > > 
> > >  README        |  2 ++
> > >  common/config |  1 +
> > >  common/rc     | 29 +++++++++++++++++++++++++++++
> > >  3 files changed, 32 insertions(+)
> > > 
> > > diff --git a/README b/README
> > > index 63f0641a..e9284b22 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -129,6 +129,8 @@ Preparing system for tests:
> > >                 xfs_check to check the filesystem.  As of August 2021,
> > >                 xfs_repair finds all filesystem corruptions found by xfs_check,
> > >                 and more, which means that xfs_check is no longer run by default.
> > > +	     - Set KCONFIG_PATH to specify your preferred location of kernel
> > > +	       config file.
> > 
> > The indentation here looks kind of off, but the core logic looks
> > correct.
> 
> The file uses a mixture of tabs and spaces. In this case I used tabs,
> the bullet point above uses spaces, that's why it looks kind of off in
> the patch. Otherwise I used the same indentation as some other
> bullet points so I don't think there is anything to fix in this patch.

LOL, so the last addition was from me?  Which added more inconsistent indent?

HA.  Objection withdrawn. :D

> > 
> > With that fixed:
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> Thanks for the review.

NP.

--D

> -Lukas
> 
> > 
> > --D
> > 
> > >  
> > >          - or add a case to the switch in common/config assigning
> > >            these variables based on the hostname of your test
> > > diff --git a/common/config b/common/config
> > > index 164381b7..e0a5c5df 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -226,6 +226,7 @@ export OPENSSL_PROG="$(type -P openssl)"
> > >  export ACCTON_PROG="$(type -P accton)"
> > >  export E2IMAGE_PROG="$(type -P e2image)"
> > >  export BLKZONE_PROG="$(type -P blkzone)"
> > > +export GZIP_PROG="$(type -P gzip)"
> > >  
> > >  # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
> > >  # newer systems have udevadm command but older systems like RHEL5 don't.
> > > diff --git a/common/rc b/common/rc
> > > index 0d261184..84154868 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -4703,6 +4703,35 @@ _require_names_are_bytes() {
> > >          esac
> > >  }
> > >  
> > > +_has_kernel_config()
> > > +{
> > > +	option=$1
> > > +	uname=$(uname -r)
> > > +	config_list="$KCONFIG_PATH
> > > +		     /proc/config.gz
> > > +		     /lib/modules/$uname/build/.config
> > > +		     /boot/config-$uname
> > > +		     /lib/kernel/config-$uname"
> > > +
> > > +	for config in $config_list; do
> > > +		[ ! -f $config ] && continue
> > > +		[ $config = "/proc/config.gz" ] && break
> > > +		grep -qE "^${option}=[my]" $config
> > > +		return
> > > +	done
> > > +
> > > +	[ ! -f $config ] && _notrun "Could not locate kernel config file"
> > > +
> > > +	# We can only get here with /proc/config.gz
> > > +	_require_command "$GZIP_PROG" gzip
> > > +	$GZIP_PROG -cd $config | grep -qE "^${option}=[my]"
> > > +}
> > > +
> > > +_require_kernel_config()
> > > +{
> > > +	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
> > > +}
> > > +
> > >  init_rc
> > >  
> > >  ################################################################################
> > > -- 
> > > 2.31.1
> > > 
> > 
> 
