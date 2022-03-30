Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959614EC693
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Mar 2022 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiC3OcR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Mar 2022 10:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346876AbiC3OcQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Mar 2022 10:32:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F47040E5C
        for <linux-ext4@vger.kernel.org>; Wed, 30 Mar 2022 07:30:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 95B271F44F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648650629;
        bh=+bl020Z/De+/SYlhSMEPGxDuXJ8Dgwgjfn88nyw7iI0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=noh+8jMGcA+4ykcMlpFMEpKxjMINB0gdBWNsL93BMb915R0uvzbilMuJcwiBTXmrO
         kWv3R53mZXThPxojEhk/oh2Jf2qudsvsJU2/ox/Vb4jXS/Pfz441lC9Nf8O/taK3c4
         HQI8tazhVyXFAoEzyjzWs8UwzbfmT/VP8AO8ZFSNu8TArtxcodSd2VDz8DOBcOUzzQ
         pO5lIoG/D2yoHlTZQkMxAObA6awRMLNfwnhvMy0SOi5TnHuBluUgAEMaTE0b7yNPWS
         dWNH/Cpb1eROkmzjecFi8iawxY3wE5U1Ef6OlAKFQz7EqPrWXeoTtxzTygjAn1vdRx
         nTO80GN00D0ag==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Andreas Dilger <adilger@whamcloud.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] misc: use ext2_ino_t instead of ino_t
Organization: Collabora
References: <20220329211712.25506-1-adilger@whamcloud.com>
Date:   Wed, 30 Mar 2022 10:30:26 -0400
In-Reply-To: <20220329211712.25506-1-adilger@whamcloud.com> (Andreas Dilger's
        message of "Tue, 29 Mar 2022 15:17:12 -0600")
Message-ID: <87y20rpl6l.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Andreas Dilger <adilger@whamcloud.com> writes:

> Some of the new fastcommit and casefold changes used the system
> "ino_t" instead of "ext2_ino_t" for handling filesystem inodes.
> This causes printf warnings if "ino_t" is of a different size.
> Use the library "ext2_ino_t" for consistency.
>
> Signed-off-by: Andreas Dilger <adilger@whamcloud.com>

Hi Andreas,

feel free to add

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi
