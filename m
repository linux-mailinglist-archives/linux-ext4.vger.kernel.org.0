Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E35523665
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 16:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245481AbiEKO6H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 10:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245265AbiEKO6C (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 10:58:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766DA1FD871;
        Wed, 11 May 2022 07:57:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24BEvccQ001174
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 10:57:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652281059; bh=p7W8ngs+T1s6AgMafAzc1Nfv8CN1Pg+DEvCQpWtMAE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BEAIus/YI2XAGT/DpmlUNxwWxE2HbqQFv1lKWgGVSNsrctM/c6LhU6BHTzJkc+xFt
         vgKj5tI1X9FbUXPOPbXej9R1vtZDEpP6orX1KO9XoBDxo1vjcdv+CWGGsAhr7iPth/
         RJ+IN6Ovl1FaA07x4GDNDcWpCttmdPSKLh2Q5Adq7+KPCl9X1ZzkwZpn0JaRPfk7/w
         BJrKCMQkW6wL8sjeOALT3R/yLX9BwDmVBBl/bXN8Fz0xEyJQpjGApebuS6un5l+7x0
         Nm+/GYvWSyT+c5j2HAWYrje+fCyN7H0kTnPLvhx5sFQAAUoXTD4oNrjkwX+VxY6o6D
         8R0EFZTtK8rSA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0B33315C3F0C; Wed, 11 May 2022 10:57:38 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chin Yik Ming <yikming2222@gmail.com>, adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix typo
Date:   Wed, 11 May 2022 10:57:36 -0400
Message-Id: <165228104687.396881.13153679979038117594.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220402090744.8918-1-yikming2222@gmail.com>
References: <20220402090744.8918-1-yikming2222@gmail.com>
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

On Sat, 2 Apr 2022 02:07:44 -0700, Chin Yik Ming wrote:
> 'functoin' and 'entres' should be 'function' and 'entries' respectively
> 
> 

Applied, thanks!

[1/1] ext4: Fix typo
      commit: 5475b2de3333be6f7a6c04f461c9f64446e5e7cd

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
