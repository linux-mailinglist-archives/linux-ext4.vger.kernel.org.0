Return-Path: <linux-ext4+bounces-5859-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E36F89FE37B
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 08:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2977A1139
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Dec 2024 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E724155345;
	Mon, 30 Dec 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gXLypQBw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E491632D9;
	Mon, 30 Dec 2024 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735545246; cv=none; b=FGYTlAha5lfEQykBSNIlSSbyQPtzC1REduvCHEi91YzMOhgPMcMAECgUHR+NG0DIJNx+tB+aJy77FcuYSNqwfbxXevF0mV9zx5O0/1PLcDf52COcvJUj0IqpEB+7fEXhVFSDZEmQZe9WdLwkqzst7fwJX04PmdrwhpJsVNRnpj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735545246; c=relaxed/simple;
	bh=lZbX6kPAzP5Q8U01t+yzuTxgkeCVklNcfq2bWwX5uEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjIuvTbu8MQqCzviaVSZjbPanrYUIw0oD1prNIygNdcOW664pqzyP7lRxMhKy2eigg86v4tEMrgxwFRWUdZ7BiWdoi7aS8buJC2dJtIcGjvXc19Tx3+bJOAmLuKkjNpCo3dnq2Duyr9cdRHMMffHTYnn2J4cIa6zovED6ABFf4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gXLypQBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1ABC4CED0;
	Mon, 30 Dec 2024 07:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735545246;
	bh=lZbX6kPAzP5Q8U01t+yzuTxgkeCVklNcfq2bWwX5uEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXLypQBwdqAiPHlvD/7u4RXwqV1uhnNDzZ1UZKLGZbes7dPkNSVCTEAm2y7k8o/Md
	 6Hejxm+unZnaYVemKbvSV7X5msAVXyQnmWtMYoleqfTsAlQXp4FZJVBn9ANBHCjdXJ
	 EqX3Dabz0DD1zdN+DRO090nIIrcjCTv2I5wL1wRo=
Date: Mon, 30 Dec 2024 08:54:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Baokun Li <libaokun1@huawei.com>
Cc: cve@kernel.org, linux-cve-announce@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>,
	Theodore Ts'o <tytso@mit.edu>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	Yang Erkun <yangerkun@huawei.com>
Subject: Re: CVE-2024-50191: ext4: don't set SB_RDONLY after filesystem errors
Message-ID: <2024123021-goatskin-mushroom-208e@gregkh>
References: <2024110851-CVE-2024-50191-f31c@gregkh>
 <cbbdac31-c63c-418e-ba00-bb82b96144ee@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbbdac31-c63c-418e-ba00-bb82b96144ee@huawei.com>

On Mon, Dec 30, 2024 at 03:27:45PM +0800, Baokun Li wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > ext4: don't set SB_RDONLY after filesystem errors
> > 
> > When the filesystem is mounted with errors=remount-ro, we were setting
> > SB_RDONLY flag to stop all filesystem modifications. We knew this misses
> > proper locking (sb->s_umount) and does not go through proper filesystem
> > remount procedure but it has been the way this worked since early ext2
> > days and it was good enough for catastrophic situation damage
> > mitigation. Recently, syzbot has found a way (see link) to trigger
> > warnings in filesystem freezing because the code got confused by
> > SB_RDONLY changing under its hands. Since these days we set
> > EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
> > filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
> > stop doing that.
> > 
> > The Linux kernel CVE team has assigned CVE-2024-50191 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> >     Fixed in 5.15.168 with commit fbb177bc1d64
> >     Fixed in 6.1.113 with commit 4061e07f040a
> 
> Since 6.1 and 5.15 don't have backport
>     commit 95257987a638 ("ext4: drop EXT4_MF_FS_ABORTED flag"),
> we won't set the EXT4_FLAGS_SHUTDOWN bit in ext4_handle_error() yet. So
> here these two commits cause us to repeatedly get the following printout:
> 
> [   42.993195] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> fsstress: Detected aborted journal
> [   42.993351] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> fsstress: Detected aborted journal
> [   42.993483] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> fsstress: Detected aborted journal
> [   42.993597] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> fsstress: Detected aborted journal
> [   42.993638] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> fsstress: Detected aborted journal
> [   42.993718] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> fsstress: Detected aborted journal
> [   42.993866] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> fsstress: Detected aborted journal
> [   42.993874] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> fsstress: Detected aborted journal
> [   42.993874] EXT4-fs error (device sda) in __ext4_new_inode:1089: Journal
> has aborted
> [   42.994059] EXT4-fs error (device sda): ext4_journal_check_start:83: comm
> fsstress: Detected aborted journal
> [   42.999893] EXT4-fs: 58002 callbacks suppressed
> [   42.999895] EXT4-fs (sda): Remounting filesystem read-only
> [   43.000110] EXT4-fs (sda): Remounting filesystem read-only
> [   43.000274] EXT4-fs (sda): Remounting filesystem read-only
> [   43.000421] EXT4-fs (sda): Remounting filesystem read-only
> [   43.000569] EXT4-fs (sda): Remounting filesystem read-only
> [   43.000701] EXT4-fs (sda): Remounting filesystem read-only
> [   43.000869] EXT4-fs (sda): Remounting filesystem read-only
> [   43.001094] EXT4-fs (sda): Remounting filesystem read-only
> [   43.001229] EXT4-fs (sda): Remounting filesystem read-only
> [   43.001365] EXT4-fs (sda): Remounting filesystem read-only
> 
> Perhaps we should revert both commits.

Maybe, if so, please send the needed info to the stable list with the
backports that have been tested.  cve@kernel.org isn't the place for
this :)

thanks,

greg k-h

