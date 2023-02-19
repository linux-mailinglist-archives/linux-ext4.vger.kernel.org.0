Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3831969BE9C
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjBSFlM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBSFlL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:11 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A4A13518
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:02 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5et5P024829
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:40:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785257; bh=AjajLZfO6HuC1qvzHhinVRyWWkNIyyOBVUIGf2WKOmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=J0tS1OJvaiYNAjD2ANZJaSDBvn85sMJnFXexlmdxEyeyqngp9wU92Fnkol0Kk5s3Z
         IhkLgk92/O1ztee0WvWUCaU83BPZZ2QA16cmBW7AnD/p4x/KVzO1hFcOOG7bh/YxJW
         VB00b9z+ls/T9u6fWBEjAGrZjsDxP8lOx1uQWxb4rhP0dJs7RRlN6Jrh/bvP75W2vL
         5foOsAxsDWVI4CxzlMtaWOjR8T2Shl+SSJ6kOyIK91dKEoIclJ0iAtfzzw2PsN0Pni
         ifVLb0K7M0nq57kNxK4bEEO8nqamiQyqiir0/BXBDRA8MFq2qQUQ+pO9NjJbFmnAM7
         7m7VK1mBADwQQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C744015C35A6; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jun Nie <jun.nie@linaro.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, tudor.ambarus@linaro.org
Subject: Re: [PATCH v2 0/2] optimize ea_inode block expansion to fix panic
Date:   Sun, 19 Feb 2023 00:40:46 -0500
Message-Id: <167678522163.2723470.3685440350984769982.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230103014517.495275-1-jun.nie@linaro.org>
References: <20230103014517.495275-1-jun.nie@linaro.org>
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

On Tue, 3 Jan 2023 09:45:15 +0800, Jun Nie wrote:
> Optimize ea_inode block expansion to avoid memcpy if possible,
> panic can be avoided in this way too.
> 
> Change vs version 1:
> Only error and warning log format in patch 2 is modified per
> Theodore's suggestion.
> 
> [...]

Applied, thanks!

[1/2] ext4: optimize ea_inode block expansion
      commit: 1e9d62d252812575ded7c620d8fc67c32ff06c16
[2/2] ext4: refuse to create ea block when umounted
      commit: f31173c19901a96bb2ebf6bcfec8a08df7095c91

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
