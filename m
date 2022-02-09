Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B614B005B
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 23:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiBIWce (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 17:32:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiBIWcd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 17:32:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEDAE018E6C;
        Wed,  9 Feb 2022 14:32:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CC6A61C64;
        Wed,  9 Feb 2022 22:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E045FC340E7;
        Wed,  9 Feb 2022 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644445955;
        bh=iywApMrpIqPa/lElQVWJWYEVMYp0khUm5qZOGk4U5/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mCyQW1bRQ5EVAoRvMj9Vu6cJ5h96jqnHL4d20JMzDM8yDnxeCQMAuWA/T+y5xV+9M
         WZi/nkb7E1v53NMKBW4tKU/9Ha/ZJt4f7dV407E+aCquVBIPPy8A/9MOCNSeO6U+ny
         Nwz5LmDK2FZ7dEnCTZEwlDw7BsoDPWogq0vQ3HckJvZSsCRuU2ns8R2PHAlOqbkWc+
         7pgRRWGRZHLDYP7tT9RLeivzL3wJixO9pe+DtRWlTUF8ue9kpOeglIKUpxUDRKbkrO
         ElFdewRU0Ccvt+ky08Lckp463KpAQydcwj7UzKgmUllduzy521QbYcxvGKUiT6z28e
         KH/EW3YDJ9jhQ==
Date:   Wed, 9 Feb 2022 14:32:34 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2 6/6] common: factor out xfs unique part from
 _filter_mkfs
Message-ID: <20220209223234.GH8313@magnolia>
References: <20220209123305.253038-1-shinichiro.kawasaki@wdc.com>
 <20220209123305.253038-7-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209123305.253038-7-shinichiro.kawasaki@wdc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 09, 2022 at 09:33:05PM +0900, Shin'ichiro Kawasaki wrote:
> Most of the code in the function _filter_mkfs is xfs unique. This is
> misleading that the function would be dedicated for xfs. Clean up the
> function by factoring out xfs unique part to _xfs_filter_mkfs in
> common/xfs. While at the same time, fix indent in _xfs_filter_mkfs to be
> consistent with other functions in common/xfs.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks!!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  common/filter | 40 +---------------------------------------
>  common/xfs    | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 39 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index c3db7a56..257227c2 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -121,53 +121,15 @@ _filter_mkfs()
>  {
>      case $FSTYP in
>      xfs)
> +	_xfs_filter_mkfs "$@"
>  	;;
>      *)
>  	cat - >/dev/null
>  	perl -e 'print STDERR "dbsize=4096\nisize=256\n"'
>  	return ;;
>      esac
> -
> -    echo "_fs_has_crcs=0" >&2
> -    set -
> -    perl -ne '
> -    if (/^meta-data=([\w,|\/.-]+)\s+isize=(\d+)\s+agcount=(\d+), agsize=(\d+) blks/) {
> -	print STDERR "ddev=$1\nisize=$2\nagcount=$3\nagsize=$4\n";
> -	print STDOUT "meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks\n";
> -    }
> -    if (/^\s+=\s+sectsz=(\d+)\s+attr=(\d+)/) {
> -        print STDERR "sectsz=$1\nattr=$2\n";
> -    }
> -    if (/^\s+=\s+crc=(\d)/) {
> -        print STDERR "_fs_has_crcs=$1\n";
> -    }
> -    if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+), imaxpct=(\d+)/) {
> -	print STDERR "dbsize=$1\ndblocks=$2\nimaxpct=$3\n";
> -	print STDOUT "data     = bsize=XXX blocks=XXX, imaxpct=PCT\n";
> -    }
> -    if (/^\s+=\s+sunit=(\d+)\s+swidth=(\d+) blks/) {
> -        print STDERR "sunit=$1\nswidth=$2\nunwritten=1\n";
> -	print STDOUT "         = sunit=XXX swidth=XXX, unwritten=X\n";
> -    }
> -    if (/^naming\s+=version\s+(\d+)\s+bsize=(\d+)/) {
> -	print STDERR "dirversion=$1\ndirbsize=$2\n";
> -	print STDOUT "naming   =VERN bsize=XXX\n";
> -    }
> -    if (/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+),\s+version=(\d+)/ ||
> -	/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+)/) {
> -	print STDERR "ldev=\"$1\"\nlbsize=$2\nlblocks=$3\nlversion=$4\n";
> -	print STDOUT "log      =LDEV bsize=XXX blocks=XXX\n";
> -    }
> -    if (/^\s+=\s+sectsz=(\d+)\s+sunit=(\d+) blks/) {
> -	print STDERR "logsectsz=$1\nlogsunit=$2\n\n";
> -    }
> -    if (/^realtime\s+=([\w|\/.-]+)\s+extsz=(\d+)\s+blocks=(\d+), rtextents=(\d+)/) {
> -	print STDERR "rtdev=$1\nrtextsz=$2\nrtblocks=$3\nrtextents=$4\n";
> -	print STDOUT "realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX\n";
> -    }'
>  }
>  
> -
>  # prints the bits we care about in growfs
>  # 
>  _filter_growfs()
> diff --git a/common/xfs b/common/xfs
> index 713e9fe7..053b6189 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -1275,3 +1275,44 @@ _require_scratch_xfs_bigtime()
>  		_notrun "bigtime feature not advertised on mount?"
>  	_scratch_unmount
>  }
> +
> +_xfs_filter_mkfs()
> +{
> +	echo "_fs_has_crcs=0" >&2
> +	set -
> +	perl -ne '
> +	if (/^meta-data=([\w,|\/.-]+)\s+isize=(\d+)\s+agcount=(\d+), agsize=(\d+) blks/) {
> +		print STDERR "ddev=$1\nisize=$2\nagcount=$3\nagsize=$4\n";
> +		print STDOUT "meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks\n";
> +	}
> +	if (/^\s+=\s+sectsz=(\d+)\s+attr=(\d+)/) {
> +		print STDERR "sectsz=$1\nattr=$2\n";
> +	}
> +	if (/^\s+=\s+crc=(\d)/) {
> +		print STDERR "_fs_has_crcs=$1\n";
> +	}
> +	if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+), imaxpct=(\d+)/) {
> +		print STDERR "dbsize=$1\ndblocks=$2\nimaxpct=$3\n";
> +		print STDOUT "data     = bsize=XXX blocks=XXX, imaxpct=PCT\n";
> +	}
> +	if (/^\s+=\s+sunit=(\d+)\s+swidth=(\d+) blks/) {
> +		print STDERR "sunit=$1\nswidth=$2\nunwritten=1\n";
> +		print STDOUT "         = sunit=XXX swidth=XXX, unwritten=X\n";
> +	}
> +	if (/^naming\s+=version\s+(\d+)\s+bsize=(\d+)/) {
> +		print STDERR "dirversion=$1\ndirbsize=$2\n";
> +		print STDOUT "naming   =VERN bsize=XXX\n";
> +	}
> +	if (/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+),\s+version=(\d+)/ ||
> +		/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+)/) {
> +		print STDERR "ldev=\"$1\"\nlbsize=$2\nlblocks=$3\nlversion=$4\n";
> +		print STDOUT "log      =LDEV bsize=XXX blocks=XXX\n";
> +	}
> +	if (/^\s+=\s+sectsz=(\d+)\s+sunit=(\d+) blks/) {
> +		print STDERR "logsectsz=$1\nlogsunit=$2\n\n";
> +	}
> +	if (/^realtime\s+=([\w|\/.-]+)\s+extsz=(\d+)\s+blocks=(\d+), rtextents=(\d+)/) {
> +		print STDERR "rtdev=$1\nrtextsz=$2\nrtblocks=$3\nrtextents=$4\n";
> +		print STDOUT "realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX\n";
> +	}'
> +}
> -- 
> 2.34.1
> 
