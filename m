Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B692D319900
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Feb 2021 05:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbhBLEOf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 23:14:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36703 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229493AbhBLEOe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 23:14:34 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 11C4DV9E031362
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Feb 2021 23:13:33 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4A65115C3601; Thu, 11 Feb 2021 23:13:31 -0500 (EST)
Date:   Thu, 11 Feb 2021 23:13:31 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] ext: EXT4_KUNIT_TESTS should depend on EXT4_FS
 instead of selecting it
Message-ID: <YCYAa8ZJHn5uJMj/@mit.edu>
References: <20210122110234.2825685-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122110234.2825685-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 22, 2021 at 12:02:34PM +0100, Geert Uytterhoeven wrote:
> EXT4_KUNIT_TESTS selects EXT4_FS, thus enabling an optional feature the
> user may not want to enable.  Fix this by making the test depend on
> EXT4_FS instead.
> 
> Fixes: 1cbeab1b242d16fd ("ext4: add kunit test for decoding extended timestamps")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thanks.

					- Ted
