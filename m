Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE6C69BEA5
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBSFlw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBSFlj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:39 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4228E1420C
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:30 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5ewTV024906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785261; bh=5cnL9I7JkCyml3gtDoRa2eEeUtLcEKw8Gg8L+Xy8gao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aXKP+oCwLUEiR+11hu1guqumAhmBhIMwjvZlRMGGjuGjiuqsSt9AYO337Wtqx2Fyn
         Izbmb25bG4f2EsK1qfckfEu/tNk9SoGPshVKh3JP8cffSA/VITXeKcrEvNBzX1KOtN
         xsPf5vZ2Y5AwwKOVscKqCJtfAIrRw4l4h7gmXr/dzLm7jjz4Yp70JsA9D/dNbyQESr
         d/NYaWWkLFH6NlDFAX1VzHGyVHjmcEFwHsx/zVpS9xJbqwHQDdSJNoFCQye5LXzbsd
         hPmPZqKIopXj00k5QGc7y9NJ6NxYZutz895ntJLyauCCrK667H4JB9+733yN6HDYPC
         qeG/Ty8ubheeg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D413215C35AE; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yi.zhang@huawei.com,
        yukuai3@huawei.com, adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [RFC PATCH v2] ext4: dio take shared inode lock when overwriting preallocated blocks
Date:   Sun, 19 Feb 2023 00:40:53 -0500
Message-Id: <167678522161.2723470.15996894909319894248.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221226062015.3479416-1-yi.zhang@huaweicloud.com>
References: <20221226062015.3479416-1-yi.zhang@huaweicloud.com>
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

On Mon, 26 Dec 2022 14:20:15 +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> In the dio write path, we only take shared inode lock for the case of
> aligned overwriting initialized blocks inside EOF. But for overwriting
> preallocated blocks, it may only need to split unwritten extents, this
> procedure has been protected under i_data_sem lock, it's safe to
> release the exclusive inode lock and take shared inode lock.
> 
> [...]

Applied, thanks!

[1/1] ext4: dio take shared inode lock when overwriting preallocated blocks
      commit: 240930fb7e6b52229bdee5b1423bfeab0002fed2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
