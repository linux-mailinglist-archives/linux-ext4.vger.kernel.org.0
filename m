Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEAD69BE9A
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBSFlO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBSFlN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:13 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD3D1350F
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:08 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5evua024889
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785260; bh=FKWmy3Qx4/LRt9+DBIawgClF6sMZzztRBF/z65pju4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=W2UBaG+YDE+DFXCjggaqow+t9vrHwYiQwsCrgQnEKa0xWIAmhCIoBDI5phoT0yrrw
         nauNCeDm8hIpo79CgdB2+bfOA2Zb9HnCPDUqUbeeNHsTfxVVSPmDUFSaURp6fkv2c2
         sjEo5tkZXRcbseTr6Fl6/018h9LCvns146F3rjpLdGIjN9wWmbjI2jsXf4dQbCRusK
         8/RkU5WuEZ/1K7bHy1lWIR9YvFLgOmkTouFWjlibI0PHTxK0yFAZx/JRKTJKfIAsuE
         z3G+TouGAFgf9mLzNbrMlpt7q0d/Q9N4qlgeLYDbgs9NbDKRMcnP3rKbVNdNs7dFPh
         uR5N6W8XUIYwQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CED0315C35AA; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, XU pengfei <xupengfei@nfschina.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] fs/ext4/inode.c: Remove unnecessary variable initialization
Date:   Sun, 19 Feb 2023 00:40:50 -0500
Message-Id: <167678522164.2723470.8999691512656829391.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230104055229.3663-1-xupengfei@nfschina.com>
References: <20230104055229.3663-1-xupengfei@nfschina.com>
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

On Wed, 4 Jan 2023 13:52:29 +0800, XU pengfei wrote:
> Variables are assigned first and then used. Initialization is not required.
> 
> 

Applied, thanks!

[1/1] fs/ext4/inode.c: Remove unnecessary variable initialization
      commit: 7fc51f923ea6b1c6f304789965414149eaedb358

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
