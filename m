Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73E056B0DE
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 05:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbiGHDU0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 23:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237065AbiGHDUW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 23:20:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED986EEBF
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 20:20:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2683JxoB032643
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 23:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657250402; bh=ddaMaG2VWMPJwD02ZENd8LExemS9R1QwwVkXDES7UEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SKnPAW+Q1gLIDDbpdGUlM3EF9kbEJiRvxkejYJbZt1GUmo+RgoEKEwvdOfGIZDAWE
         h+0m7bIniS5ZwtcXZt6xDihRQzxFOtliMNUepmadcRs9x77C11yb6otlgIJP8/VvBP
         sYd9d8acopUyBM2dylksfpXG3o7mh/56zOGgZbW8ziEFng+FFQBmktThIJlqG/8Va8
         4HsxjxW7mE9Cd/n7cJsavo5Uo3az3oZ3bx5JRHUFcu91T/JC//w8oajvSqOnjBXO2J
         PEZuAG2zSayRO7/yyTbj7VB9nE5ER+slIvZ2D8Zon//Y38HkwEl3urMg7+oEToWJXi
         DzgYsU4Z4Hn+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8CD5915C4343; Thu,  7 Jul 2022 23:19:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yi.zhang@huawei.com, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com,
        adilger.kernel@dilger.ca, openglfreak@googlemail.com, jack@suse.cz
Subject: Re: [PATCH] ext4: fix reading leftover inlined symlinks
Date:   Thu,  7 Jul 2022 23:19:57 -0400
Message-Id: <165725003056.1812964.3320513804321929175.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220630090100.2769490-1-yi.zhang@huawei.com>
References: <20220630090100.2769490-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 30 Jun 2022 17:01:00 +0800, Zhang Yi wrote:
> Since commit 6493792d3299 ("ext4: convert symlink external data block
> mapping to bdev"), create new symlink with inline_data is not supported,
> but it missing to handle the leftover inlined symlinks, which could
> cause below error message and fail to read symlink.
> 
>  ls: cannot read symbolic link 'foo': Structure needs cleaning
> 
> [...]

Applied, thanks!

[1/1] ext4: fix reading leftover inlined symlinks
      commit: f50f5a5eac8092fb9b3365ca4b1d7407cdab8427

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
