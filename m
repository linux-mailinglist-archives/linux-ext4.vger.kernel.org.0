Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B66E996A
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Apr 2023 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjDTQWA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Apr 2023 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjDTQV7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Apr 2023 12:21:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B52139
        for <linux-ext4@vger.kernel.org>; Thu, 20 Apr 2023 09:21:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLoSQ022490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007712; bh=UxBUDsjT+gysYN/huKlEY0ssKcBTz1EANcbiRBrn5jc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=X09Gp1WUCk4xizrkvO0KR7FvWYRIzUTsPGA2vINAXNmG5t5E5KMgWkZRw6NgR1MbI
         vL+1cSLnnirQxO2C7eahLY29tqE5GBmDOrvIiML91z+htnwEuvLC48b4fRqmuiRt3q
         id2ZjbxoIWpEIIt5AhOnD6wBUJy9ZIZ/iMELNtKLs/07X+z0vqoHWOsFe4EfW6hS0q
         jlEAHgxNMwNDkCCHUWXC1LiI21IQZlBxrvdDcxA3tXiERLdikT9g2KRdz6df0EwdAy
         3ThK7n/7bfkk5w+Pcj0hJTlLO7oD0Zrmf5uq8QWN5is5T3XRrisQYCdJ0w/nfLRjgS
         3wPrLkHWZjslg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E50E215C543C; Thu, 20 Apr 2023 09:47:12 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3] ext4: Add a uapi header for ext4 userspace APIs
Date:   Thu, 20 Apr 2023 09:47:08 -0400
Message-Id: <168199842265.1078192.4760923882826249852.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <680175260970d977d16b5cc7e7606483ec99eb63.1680402881.git.josh@joshtriplett.org>
References: <680175260970d977d16b5cc7e7606483ec99eb63.1680402881.git.josh@joshtriplett.org>
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


On Sun, 02 Apr 2023 11:37:42 +0900, Josh Triplett wrote:
> Create a uapi header include/uapi/linux/ext4.h, move the ioctls and
> associated data structures to the uapi header, and include it from
> fs/ext4/ext4.h.
> 
> 

Applied, thanks!

[1/1] ext4: Add a uapi header for ext4 userspace APIs
      commit: 519fe1bae7e20fc4e7f179d50b6102b49980e85d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
