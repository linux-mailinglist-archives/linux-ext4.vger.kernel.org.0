Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E418645992
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 13:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLGMDU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 07:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiLGMDU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 07:03:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E60248E2;
        Wed,  7 Dec 2022 04:03:18 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 476DF21C43;
        Wed,  7 Dec 2022 12:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670414597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3WRQ0AODchCGFbUuvDHlnmympYC9bYtk3pQXjwDDvE=;
        b=1pHZp4UnQLr1K623RgYtry6plRMatvIS+nTMO8gKhIkXB5jxLPXMD6BpzswcetjtxE7Z93
        nbSmT7TdqA9pV9qUFi0XJM7Ha651lC8CDv3WTfstz+ux5e8C87dBK9XuGDXigcOxHJKA/4
        pZjru+8NnPpCAn6FAsWf3aeDST2kpd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670414597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m3WRQ0AODchCGFbUuvDHlnmympYC9bYtk3pQXjwDDvE=;
        b=D5ZSM/+fDrYU+e5q0FxCFhV0p7CANb17nmKFr7I6z9ldALNjDj1AyBDm7NcaCcZ2989ACl
        GVBHlBQQBeemtVCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 188B5136B4;
        Wed,  7 Dec 2022 12:03:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id DuPyBQWBkGN4PwAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 12:03:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 658E0A0725; Wed,  7 Dec 2022 13:03:16 +0100 (CET)
Date:   Wed, 7 Dec 2022 13:03:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yebin (H)" <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ext4: add primary check extended attribute inode
 in ext4_xattr_check_entries()
Message-ID: <20221207120316.nzyuxofwlvbmqhsk@quack3>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-3-yebin@huaweicloud.com>
 <20221207111437.birh6zujw4wauvhu@quack3>
 <63907B8A.9030800@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63907B8A.9030800@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 07-12-22 19:39:54, yebin (H) wrote:
> 
> 
> On 2022/12/7 19:14, Jan Kara wrote:
> > On Wed 07-12-22 15:40:39, Ye Bin wrote:
> > > From: Ye Bin <yebin10@huawei.com>
> > > 
> > > Add primary check for extended attribute inode, only do hash check when read
> > > ea_inode's data in ext4_xattr_inode_get().
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ...
> > 
> > > +static inline int ext4_xattr_check_extra_inode(struct inode *inode,
> > > +					       struct ext4_xattr_entry *entry)
> > > +{
> > > +	int err;
> > > +	struct inode *ea_inode;
> > > +
> > > +	err = ext4_xattr_inode_iget(inode, le32_to_cpu(entry->e_value_inum),
> > > +				    le32_to_cpu(entry->e_hash), &ea_inode);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	if (i_size_read(ea_inode) != le32_to_cpu(entry->e_value_size)) {
> > > +		ext4_warning_inode(ea_inode,
> > > +                           "ea_inode file size=%llu entry size=%u",
> > > +                           i_size_read(ea_inode),
> > > +			   le32_to_cpu(entry->e_value_size));
> > > +		err = -EFSCORRUPTED;
> > > +	}
> > > +	iput(ea_inode);
> > > +
> > > +	return err;
> > > +}
> > > +
> > >   static int
> > > -ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
> > > -			 void *value_start)
> > > +ext4_xattr_check_entries(struct inode *inode, struct ext4_xattr_entry *entry,
> > > +			 void *end, void *value_start)
> > >   {
> > >   	struct ext4_xattr_entry *e = entry;
> > > @@ -221,6 +247,10 @@ ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
> > >   			    size > end - value ||
> > >   			    EXT4_XATTR_SIZE(size) > end - value)
> > >   				return -EFSCORRUPTED;
> > > +		} else if (entry->e_value_inum) {
> > > +			int err = ext4_xattr_check_extra_inode(inode, entry);
> > > +			if (err)
> > > +				return err;
> > >   		}
> > >   		entry = EXT4_XATTR_NEXT(entry);
> > >   	}
> > So I was thinking about this. It is nice to have the inode references
> > checked but OTOH this is rather expensive for a filesystem with EA inodes -
> > we have to lookup and possibly load EA inodes from the disk although they
> > won't be needed for anything else than the check. Also as you have noticed
> > we do check whether i_size and xattr size as recorded in xattr entry match
> > in ext4_xattr_inode_iget() which gets called once we need to do anything
> > with the EA inode.
> > 
> > Also I've checked and we do call ext4_xattr_check_block() and
> > xattr_check_inode() in ext4_expand_extra_isize_ea() so Ted's suspicion that
> > the problem comes from not checking the xattr entries before moving them
> > from the inode was not correct.
> > 
> > So to summarize, I don't think this and the following patch is actually
> > needed and brings benefit that would outweight the performance cost.
> > 
> > 								Honza
> 
> Yes, I agree with you.
> In ext4_ xattr_ check_ Entries () simply verifies the length of the extended
> attribute with
> ea_inode. If the previous patch is not merged, EXT4_ XATTR_ SIZE_ MAX is
> much larger
> than the actual constraint value. Data verification can only be postponed
> until the ea_inode
> is read.
>
> So your suggestion is to modify EXT4_ XATTR_ SIZE_ MAX Or defer data
> verification until the ea_inode is read?

My suggestion would be to take patches 1,4,5,6 from your series. So reduce
EXT4_XATTR_SIZE_MAX (if Ted agrees), use kvmalloc() instead of kmalloc(),
do the cleanup of funtion names, and fix the inode refcount leak.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
