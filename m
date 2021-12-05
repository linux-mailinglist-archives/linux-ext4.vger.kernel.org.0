Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB190468D4C
	for <lists+linux-ext4@lfdr.de>; Sun,  5 Dec 2021 21:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbhLEUmg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 5 Dec 2021 15:42:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59635 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238788AbhLEUmc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 5 Dec 2021 15:42:32 -0500
Received: from callcc.thunk.org ([63.85.23.26])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B5KcwSo010815
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Dec 2021 15:39:00 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9E6274205DB; Sun,  5 Dec 2021 15:38:58 -0500 (EST)
Date:   Sun, 5 Dec 2021 15:38:58 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Liu Wenqing <wenqingliu0120@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Page fault and infinite loop after mount and operate on crafted
 image
Message-ID: <Ya0jYmSLVj4z8RUV@mit.edu>
References: <CA+AJg7NJb1oaHpwE8s2CGpjMhk6yCc=UE9S8A=uNj-JMWb+9iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+AJg7NJb1oaHpwE8s2CGpjMhk6yCc=UE9S8A=uNj-JMWb+9iQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 04, 2021 at 12:19:06PM -0500, Liu Wenqing wrote:
> Hi,
> 
> I have found a bug with our fuzzer, attached is the image, poc file and the
> .config file and the details are as follows.

Thanks for the report!  I've opened

   https://bugzilla.kernel.org/show_bug.cgi?id=215225

to track this report.

(In my experience fuzzing reports can a while to resolve, since folks
work on them on a as-time-available-basis.  So in order to make sure
we don't lose track of any of them, I'm using bugzilla.kernel.org.
Fell free to submit feature fuzzing reports using the File systems /
ext4 component, and please prefix the bug title with "FUZZ: ", e.g.

FUZZ: Page fault and infinite loop after mount and operate on crafted image

      	   	     	      	   	       	   - Ted
