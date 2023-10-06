Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3313D7BBE65
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbjJFSGr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjJFSGo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:06:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3760C5
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6XpX008023
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615595; bh=0KCxHXzeI2bsRU5TvpqGuB9EJonKPO2kKSqOOK6bL+g=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=GBhgwvlZDQ3RNjMUqAWWSZJxzRzUAWKsjHG06uyg8vgV4aw8pNQO47JEme8wzIfAv
         MiVQbv2FfDd/9ewz5svKbmIneYJfW9/GqQ05Suf75Du0nZKN7U3jpC8GaNTCh/xSn0
         6iTAoWUynTQy/e0nR3HNDpO5eYDcNkba4zcs1pd5LDf9PRQQJDHYglkTe5twM50uFo
         n207OaNcwYZA0W+Y4CUDdte/6YMyXHQGaKKIMyCPmp0I5rf/Mk3XwKTCEndNA91IFW
         NTC+ZOAGh7ZBPMhI9PPEUCRNEGIuf94oDYUTTFDwjK8wAQVhNN6eazxClK2fn3Mfs5
         p4ZyizYvQfqeg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1D07E15C0255; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        gouhao@uniontech.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, egouriou@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: move 'ix' sanity check to corrent position
Date:   Fri,  6 Oct 2023 14:06:18 -0400
Message-Id: <169661554696.173366.320054917542877788.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230906013341.7199-1-gouhao@uniontech.com>
References: <20230906013341.7199-1-gouhao@uniontech.com>
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


On Wed, 06 Sep 2023 09:33:41 +0800, gouhao@uniontech.com wrote:
> 'ix' check should be before using it.
> 
> 

Applied, thanks!

[1/1] ext4: move 'ix' sanity check to corrent position
      commit: af90a8f4a09ec4a3de20142e37f37205d4687f28

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
