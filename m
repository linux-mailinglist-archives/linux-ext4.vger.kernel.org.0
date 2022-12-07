Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DBE6458B3
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLGLPr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiLGLPM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:15:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F919BDD;
        Wed,  7 Dec 2022 03:14:39 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D19D1FD92;
        Wed,  7 Dec 2022 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670411678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puX20SheodfWtZCreyQ6wwgI0pSk+gFmZTn3SfkKb+A=;
        b=0OIQQ+QUqVXj/b0fLMKv8Ti8CKvkvDnw7J/TSG/D2dt3t/d3MZGBsXTDyL3ruQsd8lY5N3
        rtTahlcVuT7cEGhRmCgD3CK2XC5Wxzq1Dlgfe6rDIpTu/wgZVcKYP/qGKMuMmuNaO5Pvzy
        9G0znUt6B1sgpapnvigU/Aq7RXVv8T0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670411678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puX20SheodfWtZCreyQ6wwgI0pSk+gFmZTn3SfkKb+A=;
        b=oItqsgzZXb1TzmKH6x8Xl0St6hmx3vmjszWyMKp0j08KDO6IRG9YrjV8fFHmC6ZL9M3U0n
        DfyrWGFdLJ2DByDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4DD10134CD;
        Wed,  7 Dec 2022 11:14:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id PRT4Ep51kGOAJQAAGKfGzw
        (envelope-from <jack@suse.cz>); Wed, 07 Dec 2022 11:14:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D83ADA0725; Wed,  7 Dec 2022 12:14:37 +0100 (CET)
Date:   Wed, 7 Dec 2022 12:14:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v2 2/6] ext4: add primary check extended attribute inode
 in ext4_xattr_check_entries()
Message-ID: <20221207111437.birh6zujw4wauvhu@quack3>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-3-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207074043.1286731-3-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 07-12-22 15:40:39, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Add primary check for extended attribute inode, only do hash check when read
> ea_inode's data in ext4_xattr_inode_get().
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

...

> +static inline int ext4_xattr_check_extra_inode(struct inode *inode,
> +					       struct ext4_xattr_entry *entry)
> +{
> +	int err;
> +	struct inode *ea_inode;
> +
> +	err = ext4_xattr_inode_iget(inode, le32_to_cpu(entry->e_value_inum),
> +				    le32_to_cpu(entry->e_hash), &ea_inode);
> +	if (err)
> +		return err;
> +
> +	if (i_size_read(ea_inode) != le32_to_cpu(entry->e_value_size)) {
> +		ext4_warning_inode(ea_inode,
> +                           "ea_inode file size=%llu entry size=%u",
> +                           i_size_read(ea_inode),
> +			   le32_to_cpu(entry->e_value_size));
> +		err = -EFSCORRUPTED;
> +	}
> +	iput(ea_inode);
> +
> +	return err;
> +}
> +
>  static int
> -ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
> -			 void *value_start)
> +ext4_xattr_check_entries(struct inode *inode, struct ext4_xattr_entry *entry,
> +			 void *end, void *value_start)
>  {
>  	struct ext4_xattr_entry *e = entry;
>  
> @@ -221,6 +247,10 @@ ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
>  			    size > end - value ||
>  			    EXT4_XATTR_SIZE(size) > end - value)
>  				return -EFSCORRUPTED;
> +		} else if (entry->e_value_inum) {
> +			int err = ext4_xattr_check_extra_inode(inode, entry);
> +			if (err)
> +				return err;
>  		}
>  		entry = EXT4_XATTR_NEXT(entry);
>  	}

So I was thinking about this. It is nice to have the inode references
checked but OTOH this is rather expensive for a filesystem with EA inodes -
we have to lookup and possibly load EA inodes from the disk although they
won't be needed for anything else than the check. Also as you have noticed
we do check whether i_size and xattr size as recorded in xattr entry match
in ext4_xattr_inode_iget() which gets called once we need to do anything
with the EA inode.

Also I've checked and we do call ext4_xattr_check_block() and
xattr_check_inode() in ext4_expand_extra_isize_ea() so Ted's suspicion that
the problem comes from not checking the xattr entries before moving them
from the inode was not correct.

So to summarize, I don't think this and the following patch is actually
needed and brings benefit that would outweight the performance cost.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
