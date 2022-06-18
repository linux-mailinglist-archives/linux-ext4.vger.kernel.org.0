Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9A2550239
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 04:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiFRC7T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 22:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238030AbiFRC7R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 22:59:17 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D066C0F2;
        Fri, 17 Jun 2022 19:59:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25I2x6V1024048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jun 2022 22:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1655521148; bh=7ehJo/pUgDFBbuPJrCHggKe5cRKzTV+zfJhvkxy29Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aaJMIPJPPzxyRyqs3LGWIAFySMdDO84p4mdC5/3pvjwS1Eqq4+EZ0rCVIf6E8a2K8
         FOMfxueXav2qg4rkfbTEYimYR7CgMzWuyUZDpZVz3A+/ylMNNZZVoXK8heVsuFG5Qw
         eXR/RPXJygNw1Mq3/3o7CNvmig/2diOnR4PBz+1Ke8SB8TzTZTgoVPuz6sppvmTVkK
         K/c+azMA8EAyGG9TClIBP9VRHdUX/+96L+5XlBHarQxkqZjSzbX0iA2Bp1aIvnYhUq
         umBEaEAqiXdlCUV5ptZkABEWzIcD5g7CyaWqNOjSuClrnHub+MhgchzdD4B0cVZyQ5
         5YvKwALeODeRQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4A19D15C42F3; Fri, 17 Jun 2022 22:59:06 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca,
        Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: change variable "count" to signed integer
Date:   Fri, 17 Jun 2022 22:59:01 -0400
Message-Id: <165552108974.634564.2634497659089601268.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220530100047.537598-1-dingxiang@cmss.chinamobile.com>
References: <20220530100047.537598-1-dingxiang@cmss.chinamobile.com>
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

On Mon, 30 May 2022 18:00:47 +0800, Ding Xiang wrote:
> Since dx_make_map() may return -EFSCORRUPTED now,
> so change "count" to signed integer.
> 
> 

Applied, thanks!

[1/1] ext4: change variable "count" to signed integer
      commit: fefb759df063599ad483422eb07ef8e14c612cc2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
