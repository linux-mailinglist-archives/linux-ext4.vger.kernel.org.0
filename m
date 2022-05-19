Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5557952DF0F
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 23:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiESVTe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 17:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiESVTd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 17:19:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F826ED726
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 14:19:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B46201F45F91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652995171;
        bh=9UAgBFTt2vdRr0ftu7setFAvUFoAFx2iq2uAUNBM4AA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Im0BK9bmSGNNu17ndQ3QcKrFatwtidljSZ1Er0F77FtlZuQh7qiPBsrDwBN3HoS9z
         3s7iPjaDsY6wsKyp5PT5fSORRHmklU/Umt0gdSgmXpUcI4XMmL5h0UzoktC2Rvb2l2
         yVdciciPQWWo5z+ckfX/T8eeW1KIWqsT8auOlXQ0B5BpiPIZwWSPsm6YxvONIy+FgA
         uUEDgOyRK0yGmCqT27wiwVhCYm6A9f+5WmRFuPXnDFE7tY0aXVSt5hPg6dmP8VZrxb
         eokjrTFH5cxCgiJhuGR3yXy2f98K3kOavn0Mow8PMeSc8HB2qVolTESqdaMkWE1hXX
         n090p52E/csnQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        kernel@collabora.com
Subject: Re: [PATCH v7 0/8] Clean up the case-insensitive lookup path
Organization: Collabora
References: <20220519204645.16528-1-krisman@collabora.com>
Date:   Thu, 19 May 2022 17:19:28 -0400
In-Reply-To: <20220519204645.16528-1-krisman@collabora.com> (Gabriel Krisman
        Bertazi's message of "Thu, 19 May 2022 16:46:37 -0400")
Message-ID: <871qwpnrtr.fsf@collabora.com>
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

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> Hi Eric, Ted,
>
> This is v7 of this series (thank you for the feedback!) .  This picks up
> a few r-b tags and has one small fix asked by Eric to handle a corner
> case in ext4_match when IS_ENCRYPTED() and the key is added during
> lookup.
>

Ugh, sorry. this is a bogus submission. please, disregard.

-- 
Gabriel Krisman Bertazi
