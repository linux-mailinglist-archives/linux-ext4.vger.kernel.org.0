Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6210576AD8
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Jul 2022 01:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiGOXwi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 15 Jul 2022 19:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiGOXwh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 15 Jul 2022 19:52:37 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABEC6C117
        for <linux-ext4@vger.kernel.org>; Fri, 15 Jul 2022 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1657929156; x=1689465156;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=12G5vfObsFHYgM2xAW2erNrvONRQKINyfebPIzerN3A=;
  b=WRTnh0UnVKrLAlFBTb4rXGtO8CRzHwT/MH0cqFHvV5i7NV54WenIjL+F
   xbui08wiAhEQCSOenj1UWNe6bUFmWibAVT3rEtPpTMjMTk//xql59QoPS
   TeXDgnV7tewhEcM0hdmwICSvhMIKL0y/aiITidtS+ZzASeOa5onGcIyXf
   c=;
X-IronPort-AV: E=Sophos;i="5.92,275,1650931200"; 
   d="scan'208";a="238950493"
Subject: Re: [PATCH 1/2] ext4: reduce computation of overhead during resize
Thread-Topic: [PATCH 1/2] ext4: reduce computation of overhead during resize
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 15 Jul 2022 23:52:35 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com (Postfix) with ESMTPS id E7C49140FE8;
        Fri, 15 Jul 2022 23:52:33 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Fri, 15 Jul 2022 23:52:33 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Fri, 15 Jul 2022 23:52:32 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.036;
 Fri, 15 Jul 2022 23:52:32 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     Jan Kara <jack@suse.cz>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Thread-Index: AQHYjCeH91+dMyGz00Kz59z9i8AzhK19+ACAgABmgYCAAONsAIAA72YA
Date:   Fri, 15 Jul 2022 23:52:32 +0000
Message-ID: <23CB6B29-F40D-4359-B7E3-85515217D45B@amazon.com>
References: <D03FEE2D-DCAE-44A7-B0D3-0047808426BB@amazon.com>
 <20220714134645.r4gqax4au5el2pox@quack3>
 <63A35E4E-C7B9-4B2C-BBCC-F43BECDFEA6A@amazon.com>
 <20220715092736.oa2tfcgh5a6dcpnf@quack3>
In-Reply-To: <20220715092736.oa2tfcgh5a6dcpnf@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.111]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08A746C65FE92C4EBA5B6B9A9BD23E18@amazon.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-15.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


> On Jul 15, 2022, at 2:27 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you can confirm the sender and know t=
he content is safe.
>=20
>=20
>=20
> On Thu 14-07-22 19:53:38, Kiselev, Oleg wrote:
>>>=20
>>>> +       sbi->s_overhead +=3D overhead;
>>>> +       es->s_overhead_clusters =3D cpu_to_le32((unsigned long) sbi->s=
_overhead);
>>>                                               ^^^ the typecast looks
>>> bogus here...
>>=20
>> This cast is the reverse of le32_to_cpu() cast done in fs/ext4/super.c:_=
_ext4_fill_super():
>>        sbi->s_overhead =3D le32_to_cpu(es->s_overhead_clusters);
>> And follows the logic of casting done in fs/ext4/ioctl.c:set_overhead() =
and fs/ext4/ioctl.c:ext4_update_overhead().
>=20
> I didn't mean the cpu_to_le32() call but rather the (unsigned long) part.
> That is pointless because sbi->s_overhead is already 'unsigned long' and
> even if it was not, I have hard time seeing a reason why would casting to
> unsigned long make any difference here.

Got it.  You are right.  The indent of your comment got mangled by mail, so=
 it looked like it was directed to cpu_to_ie32()! =20

>=20
>                                                                        Ho=
nza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

