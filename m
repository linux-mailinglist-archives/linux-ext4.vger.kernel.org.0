Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934B4468D52
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Dec 2021 21:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbhLEUqH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Dec 2021 15:46:07 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60115 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238416AbhLEUqG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Dec 2021 15:46:06 -0500
Received: from callcc.thunk.org ([63.85.23.26])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B5KgYoH011880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Dec 2021 15:42:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 151DD4205DB; Sun,  5 Dec 2021 15:42:34 -0500 (EST)
Date:   Sun, 5 Dec 2021 15:42:34 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Liu Wenqing <wenqingliu0120@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page fault in fs/ext4/namei.c: do_split when crafted image is
 mounted and operated
Message-ID: <Ya0kOnJK11lWA7UE@mit.edu>
References: <CA+AJg7NwCgxw65JbyWLbbq4aP-vbBzFMEn-=k6DrdTpWMBQbxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AJg7NwCgxw65JbyWLbbq4aP-vbBzFMEn-=k6DrdTpWMBQbxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 04, 2021 at 01:08:07PM -0500, Liu Wenqing wrote:
> 
> I have found a bug with our fuzzer, attached is the image, poc file and the
> .config file and the details are as follows.

Thanks for the report!  I've opened:

   https://bugzilla.kernel.org/show_bug.cgi?id=215227

to track this issue.

						- Ted
