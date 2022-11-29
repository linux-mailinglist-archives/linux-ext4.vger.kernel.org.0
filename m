Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800AD63CA2F
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Nov 2022 22:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236903AbiK2VMv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Nov 2022 16:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbiK2VMe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Nov 2022 16:12:34 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EF726C5;
        Tue, 29 Nov 2022 13:12:23 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2ATLCJqT029740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 16:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669756341; bh=g/EGor8m8Q9DnBuYXTaxaOxW8TyeAAYrJqaM/ODqyTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WCoh1X8t4yx0iRaLsj5C4qC9uVD7SOjlYuX914LNEwLUfRDdL9yPxTg92FbF0+Vsn
         JjRXc5tETAy9CMmDzWoGpSrxHWElo9Q3JeiaVyOfNXTBctSqZftgKntsIoLQsOdODB
         duVjgNl5BiIQZT1c+72jhJKm2PPmjO4qX+MPTUw4RD5//SeZDPxur4h008yykFd717
         YVxTrGtEfEBIoIKA+I6JJGhIzd04WAvO5EkJa0D0Kwok+09o9ApGswYjm0ip0Bm8Ni
         ks7BV3+7qB3yRxPxrqMoReFnl8hZFtiwweGR9+0mFHo3Vkexr7CKaZxGsEKxixVsuy
         JNfrzJJj2RiFg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6622D15C3AAD; Tue, 29 Nov 2022 16:12:19 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Li Zhong <floridsleeves@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca
Subject: Re: [PATCH v2] fs/ext4/xattr: check the return value of ext4_xattr_inode_dec_ref()
Date:   Tue, 29 Nov 2022 16:12:11 -0500
Message-Id: <166975630695.2135297.1954942678969463045.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220917002816.3804400-1-floridsleeves@gmail.com>
References: <20220917002816.3804400-1-floridsleeves@gmail.com>
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

On Fri, 16 Sep 2022 17:28:16 -0700, Li Zhong wrote:
> Check the return value of ext4_xattr_inode_dec_ref(), which could return
> error code and need to be warned.
> 
> 

Applied, thanks!

[1/1] fs/ext4/xattr: check the return value of ext4_xattr_inode_dec_ref()
      commit: 883a86e4276a9facf1a0fe6950e504f52b841853

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
