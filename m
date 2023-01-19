Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14B4673D7A
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 16:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjASP1m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 10:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjASP1l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 10:27:41 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF587457C4
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 07:27:40 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 30JFRBPf011472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Jan 2023 10:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1674142033; bh=E+MIiJLdpHnDIl2kpLjHrjplaNGo90XDLW6cyx2w/Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h+VLywYtvNWyEgKAOwRzAq3sVPvA35qQrqNdfHsV7Ps07+xxsHAprwn+FFXZQzJiw
         pJEPY4JhW5FMTyXMXExOx5dp1EhL9VRCPXXR+BTqBo8pTNKgCKPa6sqpw9iR+NXCrb
         0cxCMTR5bZeb/bpkclUFES3DWscZRL3aTA2FN0JHJWzGyUwMbqbWHK8VP/ZTqPPAug
         /rx7VYHRbsciOCZ99fWLVIDp8jTxBpUgx43MJ6Xr/eGiIaHtgpVJuW96FFuxrRZ+tJ
         QGYQ8pyotoxb7ps4A7+3Q5hFOqUH27J/CoK7ESkOvmGoOkslwvqXrXzauZOltJerAo
         MyblH0oLGpdiA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 71C3C15C46A8; Thu, 19 Jan 2023 10:27:11 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        linfeilong <linfeilong@huawei.com>, liuzhiqiang26@huawei.com,
        Lukas Czerner <lczerner@redhat.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] misc/fsck.c: Processes may kill other processes.
Date:   Thu, 19 Jan 2023 10:27:08 -0500
Message-Id: <167414201626.2737146.2771008516918347925.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
References: <2c8f3b3a-b6d1-9b8b-27c7-2df51236fe8c@huawei.com>
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

On Mon, 10 Oct 2022 16:56:58 +0800, zhanchengbin wrote:
> I find a error in misc/fsck.c, if run the fsck -N command, processes
> don't execute, just show what would be done. However, the pid whose
> value is -1 is added to the instance_list list in the execute
> function,if the kill_all function is called later, kill(-1, signum)
> is executed, Signals are sent to all processes except the number one
> process and itself. Other processes will be killed if they use the
> default signal processing function.
> 
> [...]

Applied, thanks!

[1/1] misc/fsck.c: Processes may kill other processes.
      commit: d08ef863feae14e4710bf2026404e6c6e06db2be

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
