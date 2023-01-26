Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F267ED10
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jan 2023 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjA0SMO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Jan 2023 13:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjA0SMN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Jan 2023 13:12:13 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFEA1ADDE
        for <linux-ext4@vger.kernel.org>; Fri, 27 Jan 2023 10:12:12 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30RIC0GG016485
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 13:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674843121; bh=VR1HHCgrpdayra+X6CjVyP/zXcodHyRtV/Q+y5naW/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=clEiuJ+MjIS6ePn2FlQ9RetcJi701xpq9HKVD2rL/AT1YbxIf2GA0ty13IcbUF0rd
         OK+GXcYVGzg6fIcargkJVtlj4aPzYzZBJQfxBWv5oz0/qO5JFjZoDO3qc5xPCYr6T0
         mWA8m1lLYB8hdJ1tvUc2D20tYjlUgmpEq0rjehgrHnpuo/jt4Iqq8m22SFo72Gcgfg
         DIJE1/oV06fSnfN41y/WgTsH41ng6BF6pmYQc5DExvoE/ZrK9wGEVuHMYXDDFqkM8g
         bSycKk8dtWJDdwxRs2yEl3lYDHF+vESziPk5gtlvhvJ6x5syusjksYClvmbC/s7+Id
         w5AK8ySQf4K1A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CA5F315C3587; Thu, 26 Jan 2023 10:49:14 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Samanta Navarro <ferivoz@riseup.net>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] Fix typos
Date:   Thu, 26 Jan 2023 10:49:13 -0500
Message-Id: <167474803984.16815.11868412791393284214.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221230120134.3t6sk7gocdpl33uj@localhost>
References: <20221230120134.3t6sk7gocdpl33uj@localhost>
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

On Fri, 30 Dec 2022 12:01:34 +0000, Samanta Navarro wrote:
> Typos found with codespell.
> 
> 

Applied, thanks!

[1/1] Fix typos
      commit: 206541974a2356208480a5da9df676569cbb0793

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
