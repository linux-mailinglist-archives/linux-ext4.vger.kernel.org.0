Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADB041E5EE
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 03:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351436AbhJAB7u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Sep 2021 21:59:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59085 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230283AbhJAB7s (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Sep 2021 21:59:48 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1911w00S020927
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 21:58:00 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4A7D115C34A8; Thu, 30 Sep 2021 21:58:00 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] tests: Add option to print diff output of failed tests
Date:   Thu, 30 Sep 2021 21:57:58 -0400
Message-Id: <163305345859.206740.7886516793997221269.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210902105852.72745-1-lczerner@redhat.com>
References: <20210902105852.72745-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 2 Sep 2021 12:58:52 +0200, Lukas Czerner wrote:
> Add variable $PRINT_FAILED which when set will print the diff output of
> a failed test.
> 
> 

Applied, thanks!

[1/1] tests: Add option to print diff output of failed tests
      commit: e99e05864464001864b5b17eee2e9a309a7878a9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
