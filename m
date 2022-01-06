Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D26485FF8
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 05:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiAFEmJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 23:42:09 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39535 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234019AbiAFEmH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 23:42:07 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2064ftk1003552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 23:41:56 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 13EB115C33AD; Wed,  5 Jan 2022 23:41:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Adam Borowski <kilobyte@angband.pl>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: drop an always true check
Date:   Wed,  5 Jan 2022 23:41:52 -0500
Message-Id: <164144408579.468293.2301737506681352437.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211115172020.57853-1-kilobyte@angband.pl>
References: <20211115172020.57853-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 15 Nov 2021 18:20:20 +0100, Adam Borowski wrote:
> EXT_FIRST_INDEX(ptr) is ptr+12, which can't possibly be null; gcc-12
> warns about this.
> 
> 

Applied, thanks!

[1/1] ext4: drop an always true check
      commit: a1f051415698049680c2bfb79d703e1ff7af36a3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
