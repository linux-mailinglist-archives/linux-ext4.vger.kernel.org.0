Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0843E445
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 16:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhJ1OzK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Oct 2021 10:55:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38464 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230258AbhJ1OzJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Oct 2021 10:55:09 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19SEqbOc001439
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 10:52:38 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 79D0C15C00B9; Thu, 28 Oct 2021 10:52:37 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     CGEL <cgel.zte@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] ext4:namei: fix boolreturn.cocci warnings
Date:   Thu, 28 Oct 2021 10:52:36 -0400
Message-Id: <163543268620.1895000.2418817805477522864.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210824055543.58718-1-deng.changcheng@zte.com.cn>
References: <20210824055543.58718-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 23 Aug 2021 22:55:43 -0700, CGEL wrote:
> From: Jing Yangyang <jing.yangyang@zte.com.cn>
> 
> Return statements in functions returning bool should use true/false
> instead of 1/0.
> 
> ./fs/ext4/namei.c:1441:12-13:WARNING:return of 0/1 in function
> 'ext4_match' with return type bool
> 
> [...]

Applied, thanks!

[1/1] ext4:namei: fix boolreturn.cocci warnings
      commit: 79f75ac803a444eef5627b631e068fc442df3204

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
