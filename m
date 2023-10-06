Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30C37BBE64
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjJFSGv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbjJFSGs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:06:48 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE79C6
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:47 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6ZJU008129
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615597; bh=8RFcCDHfF91cPNRwDXhH9VV/1jSmro3GlZnud3s7mU0=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=kRADSCn5d1RlpKRjO1VydBMD7ZlUYaiWYTYK2sXfgGFL1ZY0bB4GUi2a1xWlPyJV3
         z8GOrxFi4FsQOXS2CuJNCzvSIxtgpByMc/5BzXfkdTjG7LHJyLg+zXMqDoYE0rGL/+
         SK30pj3xiWSLlseMRSLkECWqAM/w9qec7R39HTNKZPH7Kn1PsxiWx776B35O40FkuJ
         9iEbz7DSb32KJz7qTqkGRYW87auQ9ua5rq/SA72qFJ61AGWzKN5uoAxvKcJMOvttCy
         hoRwb3pe08LZE8W4AKjCbVV6RYpvWeAinCeobJrsfJRaZWDiwyvQF4ifCQJtTD9ccZ
         EJgWN2+1kRWiw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2DE5E15C0280; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4/mballoc: No need to generate from free list
Date:   Fri,  6 Oct 2023 14:06:27 -0400
Message-Id: <169661554696.173366.4478647041762605320.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <tencent_53CBCB1668358AE862684E453DF37B722008@qq.com>
References: <tencent_53CBCB1668358AE862684E453DF37B722008@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Thu, 24 Aug 2023 23:56:31 +0800, Wang Jianjian wrote:
> Commit 7a2fcbf7f85('ext4: don't use blocks freed but
> not yet committed in buddy cache init) walk the rbtree of
> freed data and mark them free in buddy to avoid reuse them
> before journal committing them, However, it is unnecessary to
> do that, because we have extra page references to buddy and bitmap
> pages, they will be released iff journal has committed and after
> process freed data.
> 
> [...]

Applied, thanks!

[1/1] ext4/mballoc: No need to generate from free list
      commit: ebf6cb7c6e1241984f75f29f1bdbfa2fe7168f88

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
