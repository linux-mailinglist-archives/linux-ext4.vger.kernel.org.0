Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89771517C41
	for <lists+linux-ext4@lfdr.de>; Tue,  3 May 2022 05:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiECDe5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 May 2022 23:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiECDe4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 May 2022 23:34:56 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4D101DD
        for <linux-ext4@vger.kernel.org>; Mon,  2 May 2022 20:31:24 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2433VIpJ015144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 May 2022 23:31:20 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D0F8D15C3EA1; Mon,  2 May 2022 23:31:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2fsck: map PROMPT_* values to prompt messages
Date:   Mon,  2 May 2022 23:31:17 -0400
Message-Id: <165154867067.863734.3098529501886543374.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211208075112.85649-1-adilger@dilger.ca>
References: <20211208075112.85649-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 8 Dec 2021 00:51:12 -0700, Andreas Dilger wrote:
> It isn't totally clear when searching the code for PROMPT_*
> constants from problem codes where these messages come from.
> Similarly, there isn't a direct mapping from the prompt string
> to the constant.
> 
> Add comments that make this mapping more clear.
> 
> [...]

Applied, thanks!

[1/1] e2fsck: map PROMPT_* values to prompt messages
      commit: c1bd25333e8986b081b82a8eb8c9173a0c7480af

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
