Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FF7BBE61
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjJFSGq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjJFSGn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:06:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F559C2
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6ZWU008119
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615597; bh=zgg/U+ncUoIVfUpYzCGmw8a+CIuTV40aMMV6ZsqRZUo=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=NjeZNhfhpNA5wlGPUGs0i9bDEDpm2Bh/flx7fHHDHCpaJlC2Ou/ULW+fRglkHgQiN
         ZuC0S/6DLOOnGlA5Dsugx72/yYskn8Mi1GaaGZfGaO+Btf8gtTEDI6eX0KaduWetjf
         GoVCpK6NuIYq1J45HvsfYc/jwlRi4Z9voPjiOzbiCfMFT+RdAePj2GUM2imgCUkiKF
         OdZS6i/0bXKYTznPSAIBjPpEVeEgwKoAmEuzQ/hfJfX9ICbs8K9j2Dq+hgUpysFWCM
         f0IwKaUKI2PO2Lditw+pJe9btIwXqOhpnqf+cz7lZYoz1AyJJUIDHSMC/UEIHPIsuS
         5ZXQ5++U4LeOg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2C32A15C027F; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org,
        Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: Fix incorrect offset
Date:   Fri,  6 Oct 2023 14:06:26 -0400
Message-Id: <169661554696.173366.7891671751658063018.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <tencent_F992989953734FD5DE3F88ECB2191A856206@qq.com>
References: <tencent_F992989953734FD5DE3F88ECB2191A856206@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Thu, 24 Aug 2023 23:23:24 +0800, Wang Jianjian wrote:
> The last argumen of ext4_check_dir_entry is dentry offset
> int the file.
> 
> 

Applied, thanks!

[1/1] ext4: Fix incorrect offset
      commit: 8fedebb5ea183994aca39af3f80623f5db42fff7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
