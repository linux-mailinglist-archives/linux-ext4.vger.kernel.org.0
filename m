Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B72508836
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Apr 2022 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353338AbiDTMe5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Apr 2022 08:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354415AbiDTMe5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Apr 2022 08:34:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A473FDA1
        for <linux-ext4@vger.kernel.org>; Wed, 20 Apr 2022 05:32:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D5E8521118;
        Wed, 20 Apr 2022 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650457929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xP5H7NjBGW+y/TT7StVgwoavMLjW4bZ1WDSDVdf51U4=;
        b=rGqnkimiopUbheSYY8IFMY8gDedoBXOQvRnX9vdBoFhNjlR4CXvKhJZPPasKzFFBhseBS2
        NbaPbmWHPHi892Sw/IEN9y3cSzjpLQS40IeGhGpxcoVJbh9OqxGySVtEV1gPfOKRSpCM5H
        TCHzN7pVeEklArUX/flQ9Hy7QiFXfWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650457929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xP5H7NjBGW+y/TT7StVgwoavMLjW4bZ1WDSDVdf51U4=;
        b=I8AhdOunNZ0pa/sRojkleUAlLkPmcCNxV+5oNpRvO5J2gdSNpAwm3zJtE27jhDLsJi8QAG
        UBgBsMoDso0jGkBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B632C2C14F;
        Wed, 20 Apr 2022 12:32:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EC046A061E; Wed, 20 Apr 2022 14:32:07 +0200 (CEST)
Date:   Wed, 20 Apr 2022 14:32:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com,
        yebin10@huawei.com
Subject: Re: [RFC PATCH v3] ext4: convert symlink external data block mapping
 to bdev
Message-ID: <20220420123207.ndw3xw7oabp6bbpn@quack3.lan>
References: <20220418063735.2067766-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418063735.2067766-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 18-04-22 14:37:35, Zhang Yi wrote:
> Symlink's external data block is one kind of metadata block, and now
> that almost all ext4 metadata block's page cache (e.g. directory blocks,
> quota blocks...) belongs to bdev backing inode except the symlink. It
> is essentially worked in data=journal mode like other regular file's
> data block because probably in order to make it simple for generic VFS
> code handling symlinks or some other historical reasons, but the logic
> of creating external data block in ext4_symlink() is complicated. and it
> also make things confused if user do not want to let the filesystem
> worked in data=journal mode. This patch convert the final exceptional
> case and make things clean, move the mapping of the symlink's external
> data block to bdev like any other metadata block does.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

The patch looks good now except for one problem:

> +static const char *ext4_get_link(struct dentry *dentry, struct inode *inode,
> +				 struct delayed_call *callback)
> +{
> +	struct buffer_head *bh;
> +
> +	if (!dentry) {
> +		bh = ext4_getblk(NULL, inode, 0, 0);

This is problematic because in RCU walk mode we must not sleep and
ext4_getblk() may sleep in ext4_map_blocks(). So we'd need some trick to
avoid that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
