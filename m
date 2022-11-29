Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC563CA34
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Nov 2022 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiK2VM4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 16:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbiK2VMf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 16:12:35 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5EE1CFD2
        for <linux-ext4@vger.kernel.org>; Tue, 29 Nov 2022 13:12:26 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ATLCJg8029730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669756340; bh=j8GlUwlYO2vAJkraMvHoDxtIg56U0Q1+a6JWqXTk0so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f6rTX+oIw9gnWGeRS93FAlgzkiXC6HQ2CGuEBZi93KxK92tmh5RH4P1PRnZuKe4Ta
         c9IavSzeqBHYhJq3PE/fIuBgihoDg/9NYzNXa2LLCuyDWZ/z55rH5uLcs0B1nb6Gz+
         Db2c4Bo3r/EAYk9yO3jNsyw02RH7r2hRxttwYq1SPP10LL3eNlRBcHmpdcqzobdH+o
         05pXzNTkBo4FdickHtwHdPo1uZ1WFdvsqbK9IgMTnztojfMVElXtA6gUuTf81ufTsR
         vkV3t2fqqkOq4jQdsarSj46iCYyjrKlS2U7FV5yFrUVg4n00A/MkzvmTUX3R7R3u5V
         wBkFxVglKDYCA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6289015C33FB; Tue, 29 Nov 2022 16:12:19 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     changfengnan <changfengnan@bytedance.com>, adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: split ext4_journal_start trace for debug
Date:   Tue, 29 Nov 2022 16:12:09 -0500
Message-Id: <166975630694.2135297.17858278984867747322.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221008120518.74870-1-changfengnan@bytedance.com>
References: <20221008120518.74870-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 8 Oct 2022 20:05:18 +0800, changfengnan wrote:
> we might want to know why jbd2 thread using high io for detail,
> split ext4_journal_start trace to ext4_journal_start_sb and
> ext4_journal_start_inode, show ino and handle type when possible.
> 
> 

Applied, thanks!

[1/1] ext4: split ext4_journal_start trace for debug
      commit: 1767a1f3e91f9cc8e94244cec67a5bb7eac47b16

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
