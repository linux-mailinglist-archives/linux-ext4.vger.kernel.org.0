Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFE2517B88
	for <lists+linux-ext4@lfdr.de>; Tue,  3 May 2022 03:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiECBOP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 May 2022 21:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiECBON (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 May 2022 21:14:13 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5053C43
        for <linux-ext4@vger.kernel.org>; Mon,  2 May 2022 18:10:38 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2430SW4T001722
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 2 May 2022 20:28:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 241B815C3EA1; Mon,  2 May 2022 20:28:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] misc: fix chattr usage message for project ID
Date:   Mon,  2 May 2022 20:28:30 -0400
Message-Id: <165153770070.842263.538583675367873971.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211201225651.58251-1-adilger@dilger.ca>
References: <20211201225651.58251-1-adilger@dilger.ca>
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

On Wed, 1 Dec 2021 15:56:51 -0700, Andreas Dilger wrote:
> Fix the "chattr -h" usage message to properly document that the
> "-p" option takes a project argument, like "-v" takes a version.
> 
> Update the man page formatting to emphasize literal strings.
> 
> 

Applied, thanks!

[1/1] misc: fix chattr usage message for project ID
      commit: 63f265c857e79bf59982985158154b3edb429e70

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
