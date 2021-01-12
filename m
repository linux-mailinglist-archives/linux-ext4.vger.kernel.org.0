Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456942F322A
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jan 2021 14:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbhALNsD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 12 Jan 2021 08:48:03 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20345 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731977AbhALNr5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 Jan 2021 08:47:57 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-244-i8hIuy4hNtCF7lb5ZonnQQ-1; Tue, 12 Jan 2021 13:46:18 +0000
X-MC-Unique: i8hIuy4hNtCF7lb5ZonnQQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 12 Jan 2021 13:46:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 12 Jan 2021 13:46:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Florian Weimer' <fweimer@redhat.com>,
        Lukas Wunner <lukas@wunner.de>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Thread-Topic: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Thread-Index: AQHW6OeTm0FM5rtghkqQZIJPrgzUmKokAGNg
Date:   Tue, 12 Jan 2021 13:46:16 +0000
Message-ID: <a9426b9dd7a4489185f6a8828c90aa64@AcuMS.aculab.com>
References: <20210106172033.GA2165@willie-the-truck>
        <20210106223223.GM1551@shell.armlinux.org.uk>
        <20210107111841.GN1551@shell.armlinux.org.uk>
        <20210107124506.GO1551@shell.armlinux.org.uk>
        <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
        <20210107133747.GP1551@shell.armlinux.org.uk>
        <CAK8P3a2J8fLjPhyV0XUeuRBdSo6rz1gU4wrQRyfzKQvwhf22ag@mail.gmail.com>
        <X/gkMmObbkI4+ip/@hirez.programming.kicks-ass.net>
        <20210108092655.GA4031@willie-the-truck>
        <CAHk-=whnKkj5CSbj-uG_MVVUsPZ6ppd_MFhZf_kpXDkh2MAVRA@mail.gmail.com>
        <20210112132049.GA26096@wunner.de>
 <877doii8n2.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <877doii8n2.fsf@oldenburg2.str.redhat.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Florian Weimer
> Sent: 12 January 2021 13:32
> 
> * Lukas Wunner:
> 
> > On Fri, Jan 08, 2021 at 12:02:53PM -0800, Linus Torvalds wrote:
> >> I appreciate Arnd pointing out "--std=gnu11", though. What are the
> >> actual relevant language improvements?
> >>
> >> Variable declarations in for-loops is the only one I can think of. I
> >> think that would clean up some code (and some macros), but might not
> >> be compelling on its own.
> >
> > Anonymous structs/unions.  I used to have a use case for that in
> > struct efi_dev_path in include/linux/efi.h, but Ard Biesheuvel
> > refactored it in a gnu89-compatible way for v5.7 with db8952e7094f.
> 
> Aren't those a GNU extension supported since GCC 3.0?

They are certainly pretty old.
The 15 year old gcc we use for release builds (so binaries work
on old distributions) supports them.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

