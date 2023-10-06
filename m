Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1BF7BBE5B
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjJFSGp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjJFSGn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:06:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE06CF
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6Xua008022
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615595; bh=aWYSBZEOHWbeeYS0BrQchSwZntzSwhCllC70YM7GUm0=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=g1UZrEIp9NyxaRPQ6o0pHekuTftzq26U+63ZsdPN+j+WhVYAW4S6m9CQINZ4Ne+NA
         Goox+l9smD1WmRNytUw8iocur94551WrXHtyOHLM4MAIhvqaOzRLNqJwLsHXMGh6Fi
         2E3cN8SEzQnHn7St9OxvP/bO9jF40WnL6Dsrp7p2BJtVlZazts99HlQpMCm+izpHR5
         HAmJvsyIQHeJnDBCPnZ2uU24ASnecSv2BO/Gx3BxO7RcjhelgAOWT4H7YzwaGrH738
         f1SfUgyIhEav5fWWIpun31brIdW3+YTL3Hj78/m7zERvdAx93pm9h1+JmGttFIFBx8
         G5na06X/EfnYQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1F0CF15C0257; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Jinke Han <hanjinke.666@bytedance.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Make running and commit transaction have their own freed_data_list
Date:   Fri,  6 Oct 2023 14:06:19 -0400
Message-Id: <169661554695.173366.16815316393743748810.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230612124017.14115-1-hanjinke.666@bytedance.com>
References: <20230612124017.14115-1-hanjinke.666@bytedance.com>
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


On Mon, 12 Jun 2023 20:40:17 +0800, Jinke Han wrote:
> When releasing space in jbd, we traverse s_freed_data_list to get the
> free range belonging to the current commit transaction. In extreme cases,
> the time spent may not be small, and we have observed cases exceeding
> 10ms. This patch makes running and commit transactions manage their own
> free_data_list respectively, eliminating unnecessary traversal.
> 
> And in the callback phase of the commit transaction, no one will touch
> it except the jbd thread itself, so s_md_lock is no longer needed.
> 
> [...]

Applied, thanks!

[1/1] ext4: Make running and commit transaction have their own freed_data_list
      commit: ce774e5365e46be73ed055302c6de123a03394ea

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
