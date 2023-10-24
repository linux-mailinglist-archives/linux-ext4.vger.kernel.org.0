Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F597D476C
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Oct 2023 08:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjJXG0Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Oct 2023 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjJXG0X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Oct 2023 02:26:23 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503C8F9
        for <linux-ext4@vger.kernel.org>; Mon, 23 Oct 2023 23:26:21 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a7af20c488so42254067b3.1
        for <linux-ext4@vger.kernel.org>; Mon, 23 Oct 2023 23:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698128780; x=1698733580; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MRLwLQJKqVoT8fAKMRJ96SHZ2jjS/GjWK4rsxxnvJlw=;
        b=LVyU92IXWcr6lzH7jV0dRJgAY+uYSTscjxqOU5Ycbqoh2H2u4cEwmgsf/IBaELuCXd
         /L38REceOHcKbggOb8wD13PXKDk40eJNZSgMMJR1VyyJOopU09xu76Tmnwi/cqsEBHPD
         BXWsskepUUimPHeGZHAu0T5OPJkoZoKZsxUSOrtu/4vLLM1d645c0fLuUzABJIVBnlaQ
         F2lZjHliuZjgH/+o4RiPHzvMJC+ulXfveXXZmklH5LB53BUx2IZAIfhA4QJzZkZGfChW
         Zs3AtBIUDKV2yS2fLWZOi9CrmhMy6xPT6h6XJl5lNP9LuhjeXjchppQNU9Ywmlep4KaH
         8dbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698128780; x=1698733580;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MRLwLQJKqVoT8fAKMRJ96SHZ2jjS/GjWK4rsxxnvJlw=;
        b=rNYa1FQ9GXjp2YrQrV4SHw4Emg5+nGvpKouoNa+n/8zKHiicDs51yUaMIR0XXtc/H3
         0eCtgPlvGGWICFbFp80mTHB2e6EkfGP2PDtr7H2V8Fmg8rZulj68XKsT0nnZHTkax/UH
         DhIlIxyRT4BVJ9aSvtzuN3oHx3KoTXXULXDv7S2oJ1xGqdF4XePDhbmO/sdNojw4wrEc
         NdnaH8vV822dHDWjWxdNS5NvUx6Z4XIEEEB//yg3+XSyrIuNUsdPJUF1BV5vYaffAa6A
         cIJjcsj3AAi1YyEo2AHaqXlK5rgVDoDTXn4WA4N7ufgImz1/4F0MqKrNoFBU2Pno1jJz
         S7ug==
X-Gm-Message-State: AOJu0Ywq/6C9La5U3UMSRDwr6VayxGSCr4azfj+iD2CygYQlMbiH0GSm
        KnZ7BBUQxp0B5ObW6wBSe/oCFA==
X-Google-Smtp-Source: AGHT+IHkd91huJN9SozlpT3bpFGAimQGDOyF8TB28iFOdp/ZJ3Ha6mPQMckl0DxRoAFPL47z13RAig==
X-Received: by 2002:a0d:cc44:0:b0:5a7:c49e:3f5c with SMTP id o65-20020a0dcc44000000b005a7c49e3f5cmr11383544ywd.21.1698128780387;
        Mon, 23 Oct 2023 23:26:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d7-20020a0df407000000b0057a8de72338sm3783004ywf.68.2023.10.23.23.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 23:26:19 -0700 (PDT)
Date:   Mon, 23 Oct 2023 23:26:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] ext4: add __GFP_NOWARN to GFP_NOWAIT in readahead
Message-ID: <7bc6ad16-9a4d-dd90-202e-47d6cbb5a136@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since mm-hotfixes-stable commit e509ad4d77e6 ("ext4: use bdev_getblk() to
avoid memory reclaim in readahead path") rightly replaced GFP_NOFAIL
allocations by GFP_NOWAIT allocations, I've occasionally been seeing
"page allocation failure: order:0" warnings under load: all with
ext4_sb_breadahead_unmovable() in the stack.  I don't think those
warnings are of any interest: suppress them with __GFP_NOWARN.

Fixes: e509ad4d77e6 ("ext4: use bdev_getblk() to avoid memory reclaim in readahead path")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c00ec159dea5..56a08fc5c5d5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -262,7 +262,7 @@ struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 {
 	struct buffer_head *bh = bdev_getblk(sb->s_bdev, block,
-			sb->s_blocksize, GFP_NOWAIT);
+			sb->s_blocksize, GFP_NOWAIT | __GFP_NOWARN);
 
 	if (likely(bh)) {
 		if (trylock_buffer(bh))
-- 
2.35.3

