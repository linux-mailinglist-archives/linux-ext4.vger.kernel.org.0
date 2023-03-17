Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224626BE004
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 05:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCQEKg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 00:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCQEKc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 00:10:32 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E647DBDE3
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 21:10:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32H4A6kX026400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 00:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679026208; bh=kI8jFCpyUqTMr2urCfTPfJfBsbIYbfdpHWMlZGBF3NM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YtcB8lRcsAYIRqcYnda0v6bYn1MEOA2vVglwkdSlOrFEX03dZ+P3r2IEzjvPHLyas
         as27Qmbe5zcd14AuVlCEKZHVYnCvD/gHKipJYGUHCcD2ByC2rO5QXGYTu+/pkQ5oBd
         xi7GI3hrnaBUWqtjQJ4zzDdzlMTssXxe6V2Gs+BSzFXr8lsqPiusEIO3hwZL91kVc/
         qE4CJ69/JzJqbXKOMGZgKkFx6ED0KVv3Buml1vE2MozQZuJYPOWXswhnJ7x4Frt5Zc
         7oGC1scHFKkUxT6rSngw9JJN4Sx7s1U0O+GbVmIWnezATs8diPLkywj18KUz+8RsGJ
         5O0xv+VfU+qKw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9C8D815C45BA; Fri, 17 Mar 2023 00:10:06 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [e2fsprogs PATCH] ci.yml: store the config.h files as workflow artifacts
Date:   Fri, 17 Mar 2023 00:10:05 -0400
Message-Id: <167902618368.3260753.12686805680760171499.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230208065858.227695-1-ebiggers@kernel.org>
References: <20230208065858.227695-1-ebiggers@kernel.org>
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

On Tue, 7 Feb 2023 22:58:58 -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Store the config.h file for each platform as a workflow artifact, so
> that it will be possible to download them and compare them to
> util/android_config.h.
> 
> 
> [...]

Applied, thanks!

[1/1] ci.yml: store the config.h files as workflow artifacts
      commit: 5df0323e879982a3ee5062b2445456226e8b690f

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
