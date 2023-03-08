Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084D06AFDE8
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 05:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCHEdx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 23:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCHEdp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 23:33:45 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9898E41B6F
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 20:33:41 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3284XTsv021500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 23:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678250012; bh=+kUWUn38BH757yTcGKYg/R+b2u1y8Z0de2DOAnM6DOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Zf6vQ1rpopLr1AUjE0sRrOn0BAUIJW5TfFE6RvYMZillJ/3pmpYiHXFny1AQtLVs2
         TSMCibUYPISvdrEKrzok+mnmoS8kZThOK9U+ytT88ui6y2CKmJJr3Y+9a8KrguBtCF
         Lwslt+1ZjgiJdCPpOJBThfD+itWO8lKCbsuWq5vP4mIvlWQ5RD0i6rXBCnPotoeTvN
         B8vtPK8NsehiXZc3B20jWgNjyuXlLngwsL12bxoJn/8+puwDCqNCX0cpynrSysoa8e
         DKE5aSUIUg2hoklSUDrTvFBJi2EZxSupYvzYTHFK/gUVUTCNKj5vzUCA3YYDiHwV00
         3kl5NSt0zCKcg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CC87A15C3441; Tue,  7 Mar 2023 23:33:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH v2] docs: ext4: modify the group desc size to 64
Date:   Tue,  7 Mar 2023 23:33:20 -0500
Message-Id: <167824999282.2129363.5569221761031906694.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230222013525.14748-1-bo.wu@vivo.com>
References: <20230222013525.14748-1-bo.wu@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 22 Feb 2023 09:35:24 +0800, Wu Bo wrote:
> Since the default ext4 group desc size is 64 now (assuming that the
> 64-bit feature is enbled). And the size mentioned in this doc is 64 too.
> Change it to 64.
> 
> 

Applied, thanks!

[1/1] docs: ext4: modify the group desc size to 64
      commit: b7eef407e5271f5135ce97bfd6e2e5009922331e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
