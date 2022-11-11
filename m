Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629D2625D27
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 15:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbiKKOhA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Nov 2022 09:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiKKOg7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Nov 2022 09:36:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9C74AF14;
        Fri, 11 Nov 2022 06:36:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEF7F219B2;
        Fri, 11 Nov 2022 14:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668177416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yP1qEjh21NAm2QyOqa0iZxvxoI3tALiOvYeNf0tbPYU=;
        b=PWU7lYskc4lolhAfRbPG9rQgX80NQPvx1DMF+cqjxk2uw8kChmlKCvW7wHV27xhWoGAbTG
        XvVOwTHo4tHdcrIZCYsz726PtmWAhYzpKJQZH9GrEl/GRrc5li8V/iSBjEL4EobBaUv+Kh
        esomJFVLcd0yNSrkkzL8KqPNe5Xga/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668177416;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yP1qEjh21NAm2QyOqa0iZxvxoI3tALiOvYeNf0tbPYU=;
        b=2GDflCjE2da3pz+XRb3Yo45oKxZjFs9QFdaSbDQ0Zjmtb7sFCAnsslbOyZk56heWGPLTEx
        I2PPPGCSz4MvYeCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAC2713357;
        Fri, 11 Nov 2022 14:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QU4qNghebmNUFQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Nov 2022 14:36:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12867A06F6; Fri, 11 Nov 2022 15:36:56 +0100 (CET)
Date:   Fri, 11 Nov 2022 15:36:56 +0100
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bo Liu <liubo03@inspur.com>, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: Fix some kernel-doc warnings
Message-ID: <20221111143656.rgggjdaudixrc2te@quack3>
References: <20221111064352.2866-1-liubo03@inspur.com>
 <482cff27-2364-acbb-576c-e1d16d18334a@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482cff27-2364-acbb-576c-e1d16d18334a@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 10-11-22 22:46:46, Randy Dunlap wrote:
> 
> 
> On 11/10/22 22:43, Bo Liu wrote:
> > The current code provokes some kernel-doc warnings:
> > 	fs/ext2/dir.c:417: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> > 
> > Signed-off-by: Bo Liu <liubo03@inspur.com>
> 
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for the patch and review. I've added it to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
