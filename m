Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B3C468D54
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Dec 2021 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbhLEUrB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Dec 2021 15:47:01 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60200 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238808AbhLEUrB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Dec 2021 15:47:01 -0500
Received: from callcc.thunk.org ([63.85.23.26])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B5KhSk0012078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Dec 2021 15:43:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 027B94205DB; Sun,  5 Dec 2021 15:43:27 -0500 (EST)
Date:   Sun, 5 Dec 2021 15:43:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Liu Wenqing <wenqingliu0120@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Meet New meeting Join a meeting Hangouts 1 of 42 Page fault in
 fs/ext4/namei.c: do_split when crafted image is mounted and operated
Message-ID: <Ya0kbx3qZCeqFRnL@mit.edu>
References: <CA+AJg7OHrVgbHuRi5Sqyt5v1PzN-OhG8NjKaanLY-_+OZPvkDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AJg7OHrVgbHuRi5Sqyt5v1PzN-OhG8NjKaanLY-_+OZPvkDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 04, 2021 at 01:33:29PM -0500, Liu Wenqing wrote:
> Hi,
> 
> I have found a bug with our fuzzer, attached is the image, poc file and the
> .config file and the details are as follows.

Even though this has a later timestamp, this looks like a duplicate of
an earlier report, but with a mangled subject line?

   	   	       	      	      	      - Ted
