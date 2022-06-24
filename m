Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E55A559A62
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jun 2022 15:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiFXNed (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jun 2022 09:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXNed (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jun 2022 09:34:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F103EABA;
        Fri, 24 Jun 2022 06:34:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6110321AD3;
        Fri, 24 Jun 2022 13:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656077670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCI4M7ZfA4jerIulB9oCCdPMHqKMXVZZDMDCVl3RQZ0=;
        b=JssuSgRM0O1FDcSl91zsXZr3HPzyV3hcBgx166C8c1sMnmGM/0oZBEgAwNJDZHUdxrtULE
        12b+DOFxc8Gm1p87ZCMGdAPKiRhLh8zlyCDzNnfTQVi9NSQx2n5QDWwbKhJwj4LUOtJ4QR
        Nito3cZUmsZPY2mfQSx/pfRg7XzNF+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656077670;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCI4M7ZfA4jerIulB9oCCdPMHqKMXVZZDMDCVl3RQZ0=;
        b=JnhLDmMQEFzkmk6HxJdz4aFwbqhYRrBuxAw4aHew6fIzSa+6ksg7kf/FCtelUSYkLIa0xY
        pH6GcO4yI7H2AZDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F1FBA2C220;
        Fri, 24 Jun 2022 13:34:29 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 807B7A062D; Fri, 24 Jun 2022 15:34:29 +0200 (CEST)
Date:   Fri, 24 Jun 2022 15:34:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ye Bin <yebin10@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH -next] ext4: avoid remove directory when directory is
 corrupted
Message-ID: <20220624133429.6n4zafa4oacns2ck@quack3.lan>
References: <20220622090223.682234-1-yebin10@huawei.com>
 <508F1BF9-1F80-4F7D-92A3-D44F82533C61@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <508F1BF9-1F80-4F7D-92A3-D44F82533C61@dilger.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 23-06-22 11:01:58, Andreas Dilger wrote:
> On Jun 22, 2022, at 3:02 AM, Ye Bin <yebin10@huawei.com> wrote:
> > 
> > Now if check directoy entry is corrupted, ext4_empty_dir may return true
> > then directory will be removed when file system mounted with "errors=continue".
> > In order not to make things worse just return false when directory is corrupted.
> 
> This will make corrupted directories undeletable, which might cause problems
> for applications also (e.g. tar or rsync always hitting errors when walking
> the tree) and the user may prefer to delete the directory and recreate it
> rather than having a permanent error in the filesystem.

Well, I guess an argument could be made that in such case users should
rather run e2fsck and *that* should remove the error from the filesystem.
It isn't like we allow other metadata corruptions to be papered over by
hiding them. I know we have this policy "corrupted dirs can be deleted"
since basically forever but in retrospection it does not seem particularly
good one to me.

> With your patch it would always return "false" if a directory block hits a
> corrupted entry instead of checking the rest of the blocks in the directory.
> Since e2fsck would put the entries from the broken block into lost+found,
> it isn't clear that the full/empty decision should be made by the presence
> of a corrupted leaf block either way.
> 
> Looking at the ext4_empty_dir() code, it looks like there are a few cases
> where it might return "true" when the directory actually has entries in it,
> but your patch doesn't address those.  IMHO, errors like the absence of "."
> and ".." should *NOT* cause the directory to be marked "empty", but it should
> continue checking blocks to see if there are valid entries.  However, Jan
> added these checks in 64d4ce8923 ("ext4: fix ext4_empty_dir() for directories
> with holes") to avoid looping forever when i_size is large and there are no
> allocated blocks in the directory, so they shouldn't just be removed, but
> they also do not fix the problem if i_size is corrupt but the first block of
> the inode is valid.
> 
> 
> It might make sense to change ext4_empty_dir() to iterate only leaf blocks
> actually allocated in the inode, rather than walking the whole of i_size by
> offset?  That would avoid the "spin forever on a huge sparse inode" problem
> that was the original reason for the addition of "." and ".." checks, and
> give a better determination of whether the directory is actually empty.
> 
> If there are only corrupt blocks or holes in the directory there is no reason
> *not* to delete it, but if there *are* valid entries (even if "." or ".." are
> missing) then the directory should not be deletable, since e2fsck will repair
> missing "." and ".." without clobbering the whole directory.

So I agree this would be a sane option as well but honestly I'm not sure
the complications are worth it. IMHO "corrupted dir is undeletable" is OK
policy because simple things are harder to break ;)...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
