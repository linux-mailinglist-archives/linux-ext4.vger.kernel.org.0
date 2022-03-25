Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C964E7B98
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Mar 2022 01:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiCYT0R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Mar 2022 15:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiCYT0O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Mar 2022 15:26:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF22C1DB3C2
        for <linux-ext4@vger.kernel.org>; Fri, 25 Mar 2022 11:58:24 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22PInqbB024473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 14:49:53 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AF40815C0038; Fri, 25 Mar 2022 14:49:52 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Andrew Perepechko <andrew.perepechko@hpe.com>
Subject: Re: [PATCH v2] ext4: truncate during setxattr leads to kernel panic
Date:   Fri, 25 Mar 2022 14:49:50 -0400
Message-Id: <164823418309.637667.12757298463000030100.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220312231830.103920-1-artem.blagodarenko@gmail.com>
References: <20220312231830.103920-1-artem.blagodarenko@gmail.com>
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

On Sat, 12 Mar 2022 18:18:30 -0500, Artem Blagodarenko wrote:
> From: Andrew Perepechko <andrew.perepechko@hpe.com>
> 
> When changing a large xattr value to a different large xattr value,
> the old xattr inode is freed. Truncate during the final iput causes
> current transaction restart. Eventually, parent inode bh is marked
> dirty and kernel panic happens when jbd2 figures out that this bh
> belongs to the committed transaction.
> 
> [...]

Applied, thanks!

[1/1] ext4: truncate during setxattr leads to kernel panic
      commit: c7cded845fc192cc35a1ca37c0cd957ee35abdf8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
