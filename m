Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33087BBE5C
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjJFSGt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjJFSGp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:06:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473FFCA
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6ZLS008105
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615597; bh=gwHSSpgFY0gqUEhmZ6QYg0HyxJlSqFP+y/D1s7YeijQ=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=acMMUUTpeoOAUZDTktdtiqfA+T8m5HTE/0g2XzwvMT7OmNFfMGUL8GQenjDImbL5H
         HwSFNmOf1UqFECAOPb+szxL3Nr3QS9ZmI+KtmJANGBbKrGLP/jp6AsLBXg3LbH4B2j
         y/YCa2NNpYxx/pKMj3zO1C5cJlyfe8nqDVq6fGO/sgxA0YZ2m3eQUs/z9EkvgL9XK5
         AiL8MXOvrtHmx3RBiCgJEfH/v16wgr4JkKUK5u15+8vwNrprSuG8Wbtej+AD5WAGSb
         JgH5ulUiQCKe4qRCJDCunVU8tvXehDjrDUbfsSi2D9PUVVlqI7fqnUiMojV9rU/Caz
         B+VWPfMKKDrsw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 272FE15C0264; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 0/1] ext4: Fix stale data exposure caused with dioread_nolock
Date:   Fri,  6 Oct 2023 14:06:23 -0400
Message-Id: <169661554698.173366.728941842508344201.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <cover.1695033645.git.ojaswin@linux.ibm.com>
References: <cover.1695033645.git.ojaswin@linux.ibm.com>
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


On Mon, 18 Sep 2023 16:15:49 +0530, Ojaswin Mujoo wrote:
> ** Changes in v3 **
> 
> - Removed accidental "---" separator in commit message.
> - Picked up Jan's Reviewed by.
> - v2:
>   https://lore.kernel.org/linux-ext4/cover.1694860198.git.ojaswin@linux.ibm.com/
> 
> [...]

Applied, thanks!

[1/1] ext4: Mark buffer new if it is unwritten to avoid stale data exposure
      commit: 2cd8bdb5efc1e0d5b11a4b7ba6b922fd2736a87f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
