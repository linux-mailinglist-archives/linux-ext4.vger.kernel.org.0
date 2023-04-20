Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9245C6E9969
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Apr 2023 18:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjDTQWB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Apr 2023 12:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjDTQV7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Apr 2023 12:21:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B4D3C38
        for <linux-ext4@vger.kernel.org>; Thu, 20 Apr 2023 09:21:58 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLqxW022542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007714; bh=l89AU5QGIzfnCGpsX+jKS6186ftCA2OuhktbME1l6WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nPqnnTfIkYqKkhmMgYeF6+V1GOkS8gCtpqRlOiCRE948QaHEIGYGBk2RRbZTFKjoG
         OtVy4EKJQp4nLdKcPN91cpYLzTY5u1qZ9j6M1cptUrNCD0K9JLZTmAW/2nBGPd5+dl
         21q23ZL5f6OYgZafv3jzLlT6PXUUkMW5Loz4CE+DqF2ZdzZJvfKhPqLdj3u2R5Glo9
         rHNq2f2V4deZbUP2qva/ok8FbnD+fvWuf2DLa9J60Bfx1kwODnYBiFnM8mWQ6yYero
         L2IZVQfbA0PurxiMpDNP5PSRAfVKb9qArDatzYA7v7jXGHTKVsrepG1BWTlcE6JdTT
         ZUYMZj88UgHBA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E676515C543D; Thu, 20 Apr 2023 09:47:12 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Tom Rix <trix@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unneeded check of nr_to_submit
Date:   Thu, 20 Apr 2023 09:47:09 -0400
Message-Id: <168199842265.1078192.14715172373184437380.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230316204831.2472537-1-trix@redhat.com>
References: <20230316204831.2472537-1-trix@redhat.com>
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


On Thu, 16 Mar 2023 16:48:31 -0400, Tom Rix wrote:
> cppcheck reports
> fs/ext4/page-io.c:516:51: style:
>   Condition 'nr_to_submit' is always true [knownConditionTrueFalse]
>  if (fscrypt_inode_uses_fs_layer_crypto(inode) && nr_to_submit) {
>                                                   ^
> This earlier check to bail, makes this check unncessary
> 	/* Nothing to submit? Just unlock the page... */
> 	if (!nr_to_submit)
> 		return 0;
> 
> [...]

Applied, thanks!

[1/1] ext4: remove unneeded check of nr_to_submit
      commit: 8ae56b4e82ee29b5cc1fbea8b00a0a7e0758f3c2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
