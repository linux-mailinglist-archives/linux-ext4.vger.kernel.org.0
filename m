Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49726BE002
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 05:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCQEKR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 00:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjCQEKO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 00:10:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E284ECE0
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 21:10:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32H4A652026395
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 00:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679026208; bh=MSMjcTfcCHXjbJRhdKLugBcJoI6T1WnkChQCqm3pPCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a5tZTLIsJeY3AiAXITq00db+ow1UZmBK0R+0iCdj4f+/BCVKfMF8+W5IICojNb9mm
         Cdt7otkvRx6/+LVNhSbUmxlo58iot9S0997HnEOR//bcrU4D9lJtuyj1PjWUEQbAj6
         z5HgjHnxLSN9rSxyR53CRO4ssm1gEqvwmaVcfz1cmyJNSNM8te+bjb8Jpy+EPNFj7W
         smuHUDdMg5biUQNOrsGfPgTRFWtfbCquQ1k/N0XzVLmjEnro/marBAWIAfreN5tFss
         ScC+/ZFDDX2Vl8uj+L357Q6VBlGn6mNQ2uUhX0vgY4+wf3Mqra7JpbolL8An+goq4s
         GmNW0kqygpxMg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9AF2015C45B9; Fri, 17 Mar 2023 00:10:06 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tests: fix u_direct_io to work with older losetup
Date:   Fri, 17 Mar 2023 00:10:04 -0400
Message-Id: <167902618367.3260753.563830335730486359.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1673323535-14317-1-git-send-email-adilger@dilger.ca>
References: <1673323535-14317-1-git-send-email-adilger@dilger.ca>
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

On Mon, 9 Jan 2023 21:05:35 -0700, Andreas Dilger wrote:
> Older losetup does not have --sector-size, but this isn't really
> needed for the test to work.  Instead specify the filesystem block
> size directly to mke2fs, so that it works on all distros instead
> of being skipped.
> 
> 

Applied, thanks!

[1/1] tests: fix u_direct_io to work with older losetup
      commit: 46413097b9ae8c14d1a4f16b43106eaa3ac4c16a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
