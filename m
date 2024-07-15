Return-Path: <linux-ext4+bounces-3279-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79593169F
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 16:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F066B221F3
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 14:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCBA18EA62;
	Mon, 15 Jul 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="RFl2Es5K"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B708618C335
	for <linux-ext4@vger.kernel.org>; Mon, 15 Jul 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053462; cv=none; b=hUqcc6Yl2wgJMclgKfNOIvxMJrok7+bC+XV/eEzGD4iWXXLRTEoTIzLENDWvaQbYZIz3z5NGDoD4lVz9JMn7XmJOPgk+3xF1jQkh2C4ZMDb1PSVvXJEUte40jrdMJGysLtgjsQwhXk0EIq6US6ei26g2HAujzmDpznVFCKC/O9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053462; c=relaxed/simple;
	bh=jadYoQb1W14XSd8A0IG5OahW5gEfDZGyZgN5UaQB+nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzayOWOCGOCMcSBD0inRVXSrY14fr4ulcY1i5EyiinRwJ0Nn4HoMoLfXkU0M3N3yvrYGtbLQlbb1XDwHbyQIObJkVSoGdql+wKWiKetoVDutNNLUMBt51H+1t4j0t18Ua01pA6wv+yoVg9DajyWZqoYMbi5vODzD2bROvnl6BeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=RFl2Es5K; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-108.bstnma.fios.verizon.net [173.48.102.108])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 46FEO3jw011524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 10:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1721053445; bh=x2y58X4Q4lxVklgROmX+Ft/OSyd8eboDgbw63MzF9mQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=RFl2Es5KsEVuHo7NnTJ2ijZGKO0jvqfso0IrLETH0oPVAIJvI5Po8jAP2dVqeRUUy
	 90NnSPW8adhMduzSIN6sTfoMCfZD/uktnajnwcKqlm91vzZzso3Nx0H+fU75tRm6x/
	 /JTQbnilWk/utDoWkH4vhwEV8MckpuH6c7DtjdcbNvAVIkrx+uaxh6xOPcz/yBQ8PD
	 cnfYzU3nRDfUcbiW1z7dytNAghIlNJTJyEhGKRIYy8dCuIeNXUcGBe7BV2m+UDCPNL
	 qcvRibLYaLYxfoxbvE3enAt0RWcxPvEFsJN26BqcI4R0+EE9maXoXN7cCfLCYgaYx9
	 MueaXtB5o4vwA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 68DA715C029B; Mon, 15 Jul 2024 10:24:03 -0400 (EDT)
Date: Mon, 15 Jul 2024 10:24:03 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Daniel Gomez <da.gomez@samsung.com>
Cc: Zorro Lang <zlang@redhat.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [Bug report]: fstests g/388 crash on ext4, BUG: kernel NULL
 pointer dereference, address: 0000000000000000
Message-ID: <20240715142403.GA70013@mit.edu>
References: <20240714034624.qz3l7f52pi6m27yx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CGME20240715042825eucas1p2f409955112396d2777f3f2a5ef3764c8@eucas1p2.samsung.com>
 <20240715042803.GM10452@mit.edu>
 <ejaxnieh5h6bfeocb7gwtonirthjvpgoveqvmfnb5ebqk33uxs@4lvgdocvt55c>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ejaxnieh5h6bfeocb7gwtonirthjvpgoveqvmfnb5ebqk33uxs@4lvgdocvt55c>

On Mon, Jul 15, 2024 at 08:01:54AM +0000, Daniel Gomez wrote:
> 
> My guess is that '-o acl,user_xattr' [1] options are now included in
> the scratch device and they were not before. This is what patch 4
> fixes. f2fs, tmpfs, reiserfs, gfs2 and ext* will be affected as well
> with their respective default mount options.

At least for ext4, acl and user_xattr are enabled by default:

% kvm-xfstests shell
...
root@kvm-xfstests:~# mount -t ext4 /dev/vdc /vdc
[   11.207917] EXT4-fs (vdc): recovery complete
[   11.209103] EXT4-fs (vdc): mounted filesystem 881ec32f-72a0-4b10-9a3f-a68c68f31f40 r/w with ordered data mode. Quota mode: none.
root@kvm-xfstests:~# cat /proc/fs/ext4/vdc/options 
...
user_xattr
acl
...
root@kvm-xfstests:~# 

> [1] From _common_mount_opts(). Snippet:
> 
> 	ext2|ext3|ext4|ext4dev)
> 		# acls & xattrs aren't turned on by default on ext$FOO
> 		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
> 		;;

Yeah, that hasn't been true for a while....

commit ea6633369458992241599c9d9ebadffaeddec164
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Wed Feb 23 17:51:51 2011 -0500

    ext4: enable acls and user_xattr by default
    
    There's no good reason to require the extra step of providing
    a mount option for acl or user_xattr once the feature is configured
    on; no other filesystem that I know of requires this.

So we probably remove that bit from _common_mount_opts.  :-)

    	       	      	       	    			 - Ted

