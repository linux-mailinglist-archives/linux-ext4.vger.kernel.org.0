Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376D477E361
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 16:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343526AbjHPORI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbjHPOQ6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 10:16:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14732708;
        Wed, 16 Aug 2023 07:16:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72DE52193C;
        Wed, 16 Aug 2023 14:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692195416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QN0QZ4EhZxkqne9Lhu9wVCaezXziJWVS9oTlVt4mZuU=;
        b=YTXPs6+o0/4ur5t0MAFBSkMkvW8XWcCfzbgJ5q4CI+ExEcbGkeiNV5XPxRaenKe/DMEPyF
        BMvGKs2ViOOByqfR+AncOTIYOZaEdfaFs8Hf0usKfsHTTMTKy6RmkXyd2/YFP94BN9i8pY
        W8uCmh4BGJlUJqVE38utFzMU8lAc8SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692195416;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QN0QZ4EhZxkqne9Lhu9wVCaezXziJWVS9oTlVt4mZuU=;
        b=ac6sG+kDovEyILlycL0tAEtNxmfrbdGNX38i5o9w/imkXGPGo/c6icHOoU4MwqKcw9ttIC
        K1TiimYj0VTSnEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 66394133F2;
        Wed, 16 Aug 2023 14:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vjTOGFja3GQDcwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Aug 2023 14:16:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D7F4DA0769; Wed, 16 Aug 2023 16:16:55 +0200 (CEST)
Date:   Wed, 16 Aug 2023 16:16:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Georg Ottinger <g.ottinger@gmx.at>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext2: fix datatype of block number in
 ext2_xattr_set2()
Message-ID: <20230816141655.5nscyyfe6vt67432@quack3>
References: <20230816052104.3374-1-g.ottinger@gmx.at>
 <e6dff0e9-9f08-2684-2bba-74570c3655a8@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6dff0e9-9f08-2684-2bba-74570c3655a8@gmx.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 16-08-23 07:31:34, Georg Ottinger wrote:
> I missed the proper format string for the debug message.

Thanks. I've fixed up the patch in my tree.

> answering Andreas question - I did check the remaining calls to
> ext2_new_block(), ext2_new_blocks() and ext2_free_blocks() within the
> ext2 directory - here the block argument is either unsigned long or
> ext2_fsblk_t (which is a typedef to unsigend long) - However I want to
> mention that the use of unsigned long / ext2_fsblk_t is inconsistent. I
> guess that ext2_fsblk_t should be the prefered data type.

Yes, that's correct. We should be using ext2_fsblk_t all over the place. In
fact unsigned long is also a questionable type. On disk the block number is
u32, so unsigned long is pointlessly big on 64-bit archs and just using u32
as ext2_fsblk_t would make more sense. But then it's possible there are
some overflows in the code currently hidden by the fact that most of the
testing happens on 64-bit where long is 64-bit. So the switch would need
somewhat careful review.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
