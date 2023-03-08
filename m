Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00896AFDE5
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 05:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjCHEdt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 23:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCHEdm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 23:33:42 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32D728D2F
        for <linux-ext4@vger.kernel.org>; Tue,  7 Mar 2023 20:33:38 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3284XVYK021546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Mar 2023 23:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1678250014; bh=nK0/F+PjoqGyeJmtF8j75L5Aa7k2eV9Y3ZR28DHzAds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BBazZ1qe3/6BcN4F4exmsANPxm9sHtnlWi/tZJXp9ODMBrk5pUk6Jyw5jFJ+oGt9a
         TJtk41oC8TyYIMno4iBdWgK2rPxnoL+g3yXQ0lEuIjn11lkyhvyuwtw7GpuzaFOlTh
         KfKjLUV2fVTP0cugqvXAlKFVoIgZh+o7YVMMQzyWKXUiO0KNeaoutmtVFafChozyaJ
         NLbakelJK0ueQIYe18b79mKJb+5gFz0R3g+ss/Bz1oOUH7IV8zXxGiTEIwtShoOnrz
         +WcT6ZipnC5nrEbau/f38LJDSAzGuNmaRD5g5VYEyOfLLWpK4R/fShc398O5vjh7Fl
         nU3jYDKH3lBIQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D4EE515C348D; Tue,  7 Mar 2023 23:33:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: make kobj_type structures constant
Date:   Tue,  7 Mar 2023 23:33:25 -0500
Message-Id: <167824999282.2129363.18336636567964036362.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230209-kobj_type-ext4-v1-1-6865fb05c1f8@weissschuh.net>
References: <20230209-kobj_type-ext4-v1-1-6865fb05c1f8@weissschuh.net>
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

On Thu, 09 Feb 2023 03:18:35 +0000, Thomas Weißschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: make kobj_type structures constant
      commit: 60db00e0a1490adcdc8b80887f7caf954d8bcd3e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
