Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF31731C0D
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbjFOPAZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbjFOPAP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 11:00:15 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882AF1FFA
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 08:00:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35FExwFv026872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 10:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686841200; bh=R3yQqPbmF4x4qIyyK84rjCG1jL5pRDSBd4Q9G4EQuuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Cf38PjhfJwaLL+2rOAuIGAgYQchpZjimnL6brOmWY8SuEDU2DrUU4KdTp8vIKVA+t
         VAtuZ31uyPeOgCJWjmSI6J5oofT7zlOfrUfL9c08bSm4bjb/hXHXYQSygiITbj4lYZ
         Fu7Il1/DZ6Uzkq1mg7Yin66QjbwbeWl6t9JSPmuhIb262AwvP4KBVFg2Hvn6cViqlx
         VlmBt1DA5fvUdbBNpUH60q0eVw8an8+IrnQCQp31/IDuTwzdcVMKjUNYOIutlSjPU9
         p2/3enXitMVL4kjDW0pXwda/OPYmis7s6BxRUMSjszDj2oia0syQO7842uat1CB3/e
         r+pIwCung02Kg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A75CC15C00B0; Thu, 15 Jun 2023 10:59:58 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Brian Foster <bfoster@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] ext4: allow concurrent unaligned dio overwrites
Date:   Thu, 15 Jun 2023 10:59:52 -0400
Message-Id: <168683994075.282246.17689753653419770593.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230314130759.642710-1-bfoster@redhat.com>
References: <20230314130759.642710-1-bfoster@redhat.com>
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


On Tue, 14 Mar 2023 09:07:59 -0400, Brian Foster wrote:
> We've had reports of significant performance regression of sub-block
> (unaligned) direct writes due to the added exclusivity restrictions
> in ext4. The purpose of the exclusivity requirement for unaligned
> direct writes is to avoid data corruption caused by unserialized
> partial block zeroing in the iomap dio layer across overlapping
> writes.
> 
> [...]

Applied, thanks!

[1/1] ext4: allow concurrent unaligned dio overwrites
      commit: d3dfa834d0c6c6a168a745185fe6a64c901c186f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
