Return-Path: <linux-ext4+bounces-9048-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BC0B0917B
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 18:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9981518888AF
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5792FA625;
	Thu, 17 Jul 2025 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKjHWyrC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C264652F66;
	Thu, 17 Jul 2025 16:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768715; cv=none; b=Hqw9X57zn4TORxHiX4XQUzD4zmakNUWeUUznAWtn0vAyvWckMZCk5pHbHJGCB2tdRGE58cwxZyE06kt+9VTfYBzDqx5CKEMsiAgfFzAAh2lpKPOGw7ZcWW+42m+AC6Bo4rD1QXlsUCU74KteIczPRlHgQXHuMZNUB8bVWET0qOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768715; c=relaxed/simple;
	bh=leH2qi5T+fPbxH0BYXBy6va7/khYJFfEzKY8QCgbiBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDdJn9L6EbyaVuioU5TREaKzljKc3Rz+BWbKkODO/kxrYHUB2yTVoPMJKkSDouXAgX9DmxTFD9mqV4mUvHzFjnYZrCcdJcYmhbb/rqV+o/wb7rz1eURPiH5JML3XKrThifPhuhzQnjzZei5qBYMqDN4r6ykS2MNbMVLh3CQ035s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKjHWyrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52440C4CEE3;
	Thu, 17 Jul 2025 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752768715;
	bh=leH2qi5T+fPbxH0BYXBy6va7/khYJFfEzKY8QCgbiBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKjHWyrCYggNTQGZ5DpW6iNTFIKlkChJWgOv03hSKTRrbkuC7Jur10tlZH/GslEVa
	 Z9UU+0S+KBz5y82979vKx16rRYKdOPc6UgiqzfEF1Un0Xvo2iNa3Rdc8kx7NW0M3TM
	 E2eJDHGDjWYGk6QYk5qxs12tYAy7wtmvuGgZ9ciakbUMtPZJfIlsViPwwa4yiaZ+aI
	 GGO3YhDSfRy3g1AIxxO70Qk++3RTpPBppUV6z6teah8cWoHrOXmTFSte+8iVEtSg20
	 Sw4LQH9vFsaWV41Nysc87/1RkD4jKgdck74CvDHdPhlZxAMT2H31fHhuJ9Yszmnbfj
	 Dr4LbI3geDC8A==
Date: Thu, 17 Jul 2025 09:11:54 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
	tytso@mit.edu, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 02/13] common/rc: Fix fsx for ext4 with bigalloc
Message-ID: <20250717161154.GF2672039@frogsfrogsfrogs>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <84a1820482419a1f1fb599bc35c2b7dcc1abbcb9.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84a1820482419a1f1fb599bc35c2b7dcc1abbcb9.1752329098.git.ojaswin@linux.ibm.com>

On Sat, Jul 12, 2025 at 07:42:44PM +0530, Ojaswin Mujoo wrote:
> Insert range and collapse range only works with bigalloc in case
> the range is cluster size aligned, which fsx doesnt take care. To
> work past this, disable insert range and collapse range on ext4, if
> bigalloc is enabled.
> 
> This is achieved by defining a new function _set_default_fsx_avoid
> called via run_fsx helper. This can be used to selectively disable
> fsx options based on the configuration.
> 
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/rc | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 9a9d3cc8..218cf253 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -5113,10 +5113,37 @@ _require_hugepage_fsx()
>  		_notrun "fsx binary does not support MADV_COLLAPSE"
>  }
>  
> +_set_default_fsx_avoid() {
> +	local file=$1
> +
> +	case "$FSTYP" in
> +	"ext4")
> +		local dev=$(findmnt -n -o SOURCE --target $file)
> +
> +		# open code instead of _require_dumpe2fs cause we don't
> +		# want to _notrun if dumpe2fs is not available
> +		if [ -z "$DUMPE2FS_PROG" ]; then
> +			echo "_set_default_fsx_avoid: dumpe2fs not found, skipping bigalloc check." >> $seqres.full
> +			return
> +		fi

I hate to be the guy who says one thing and then another, but ...

If we extended _get_file_block_size to report the ext4 bigalloc cluster
size, would that be sufficient to keep testing collapse/insert range?

I guess the tricky part here is that bigalloc allows sub-cluster
mappings and we might not want to do all file IO testing in such big
units.

> +
> +		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q bigalloc && {
> +			export FSX_AVOID+=" -I -C"

No need to export FSX_AVOID to subprocesses.

--D

> +		}
> +		;;
> +	# Add other filesystem types here as needed
> +	*)
> +		;;
> +	esac
> +}
> +
>  _run_fsx()
>  {
>  	echo "fsx $*"
>  	local args=`echo $@ | sed -e "s/ BSIZE / $bsize /g" -e "s/ PSIZE / $psize /g"`
> +
> +	_set_default_fsx_avoid $testfile
> +
>  	set -- $FSX_PROG $args $FSX_AVOID $TEST_DIR/junk
>  	echo "$@" >>$seqres.full
>  	rm -f $TEST_DIR/junk
> -- 
> 2.49.0
> 
> 

