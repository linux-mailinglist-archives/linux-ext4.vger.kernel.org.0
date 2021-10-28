Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BEF43E47B
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 16:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhJ1PCJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Oct 2021 11:02:09 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39904 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230258AbhJ1PCI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Oct 2021 11:02:08 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19SExb7s005208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 10:59:37 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3434415C00B9; Thu, 28 Oct 2021 10:59:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: scope ret locally in ext4_try_to_trim_range()
Date:   Thu, 28 Oct 2021 10:59:36 -0400
Message-Id: <163543315918.1896644.7606928624804868693.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210820120853.23134-1-lukas.bulwahn@gmail.com>
References: <20210820120853.23134-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 20 Aug 2021 14:08:53 +0200, Lukas Bulwahn wrote:
> As commit 6920b3913235 ("ext4: add new helper interface
> ext4_try_to_trim_range()") moves some code into the separate function
> ext4_try_to_trim_range(), the use of the variable ret within that
> function is more limited and can be adjusted as well.
> 
> Scope the use of the variable ret locally and drop dead assignments.
> 
> [...]

Applied, thanks!

[1/1] ext4: scope ret locally in ext4_try_to_trim_range()
      commit: fd7a2ed7b32a4ee41477a5326941b95650575c84

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
