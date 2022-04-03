Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3B34F0A6A
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Apr 2022 16:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359093AbiDCOz3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Apr 2022 10:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359090AbiDCOz2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Apr 2022 10:55:28 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86770DF9E;
        Sun,  3 Apr 2022 07:53:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 233ErMOV020998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Apr 2022 10:53:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 216F115C3E9D; Sun,  3 Apr 2022 10:53:22 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "wangjianjian (C)" <wangjianjian3@huawei.com>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4, doc: Fix incorrect h_reserved size
Date:   Sun,  3 Apr 2022 10:53:18 -0400
Message-Id: <164899700423.964485.10135107702486060180.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <92fcc3a6-7d77-8c09-4126-377fcb4c46a5@huawei.com>
References: <34889f32-7dd9-125e-2f7a-734faa395d20@huawei.com> <92fcc3a6-7d77-8c09-4126-377fcb4c46a5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 1 Apr 2022 20:07:35 +0800, wangjianjian (C) wrote:
> According to document and code, ext4_xattr_header's size is 32 bytes, so
> h_reserved size should be 3.
> 
> 

Applied, thanks!

[1/1] ext4, doc: Fix incorrect h_reserved size
      commit: e830f1a05b203e8b9b81606caf6b5d68458ba732

Note that this patch was whitespace damaged, so I had to manually
apply the patch.  It appears that all TAB characters had been replaced
with the bytes 0xC2 0x020, which is the UTF-8 encoding for U+0082, aka
'BREAK PERMITTED HERE'.  That seems.... wierd; I don't know how that
would ever be considered a valid character set transformation.

In any case, you might want to look at your Mail User Agent and see if
there are some settings you can adjust.

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
