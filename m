Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89BE7B6D31
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Oct 2023 17:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjJCPcn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Oct 2023 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjJCPcm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Oct 2023 11:32:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E14283;
        Tue,  3 Oct 2023 08:32:39 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393DtiOi017796;
        Tue, 3 Oct 2023 15:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wfJPmEVc2goe+u1Bm1OpxS0ARFXCIp8Rt2rrMdUITSY=;
 b=V5+K7E1vd2ZHIailo/+8KZrT83prk75WifwVYFoop5TCgazEwMb9vTLmLmZTikBB6Kig
 J14Mu979yk9LplAplASg+Q8c8ZrQmD6RYovEyYUIITwOhnQpBTYEYyxH3fC/pvu8wyS0
 jFH1WOuxwSFuj635hX+PXqIiYP1MokdXbfX5kfdFcoqVpVPMtFtFfUCAQ/65/laDD0xZ
 Fmih0okWSAsIgFKUZURsMQGuROZJL6gJNPGO+s93eig06BYpGNXABjJNdR+s1Oa2/ET4
 //zUrMPYtnIaUjeyltaM7EpDWJf92jNR6vjjLVhIRuxQw5R50zntrtOS7sLP3hqhJzMw BQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teakcd3b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 15:32:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393F4dT6002846;
        Tue, 3 Oct 2023 15:32:13 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea465r42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 15:32:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vifhe59R8iZHf+Zwgd2yt5NQsRnct/H17ylcYfq6T6/VRCgeSPXcS3UKXyOL0J9O3iqdOEmU9Wt2lfcRC0ic+8gJPhVB6BNq0FnUyYXofknwtl0ppPv1ksM0sGmCLNEEKfDj1JcRqpryzdS9Et5U7UKoBVLaeva4ZxS7FUG47ura84zDY9R/Ofk0wft4NpJG3Alk43XoNzAKMJc/hcRYGbjZhcJYYZDWVH+3BOqWCZE8wAkf/L0XB5j+3UWpUtkjGkmznLKF8dHFbBKMrUFErab7na/5agRnkK5hIXkmuAN/Or+XjLh3vbYi7ri0o1x/FpcfsOhOBngcXbx23AeMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfJPmEVc2goe+u1Bm1OpxS0ARFXCIp8Rt2rrMdUITSY=;
 b=XMM6BPVzls5+d+gzYGR+7cqlUkOhXhet/R+UshP33qV9zZq8OwbUFCCaeg9DxqpsuwgbE5/fU2asYEwQw/QIp9AsoMZvLMwqbjMsFoYg3qoNhN9Zc+IuIQ9Ewo3JYKvjY3JYzmSjqJq9hEsSBPavkCAPKmjdu4sjfgyirXUrOBNwXfJIha/s/LqySdXzLJT0spf4sDm7nb/0BJtqbU/5a8CdLFTjJd8w6Sqc/9VMf1ZV60pZkm73MtznX8zAOj2RQ0l+Tj7Kz/3f/aGJdpAv3jKhSBWTk/pglpLxvZCyz5N8f3tg0vt4/fdVMuj9tS3ak/S1795Jk58JFVEYP1DG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfJPmEVc2goe+u1Bm1OpxS0ARFXCIp8Rt2rrMdUITSY=;
 b=kK46OhYMy+2eAYc4fNsYJ1PT3y8X0XUCCExKeIaHE0d5uR6Ygs0NL4WpFuNWnDkPe9S6xxrjdX0Bdi24OEHd7feek61m0jG6Z/SjBg0sOo8+wn17GnYrO+bR0uk2FI7+JFg19b1TsyrQioGlizpx/qGQtP4dxJsn1MGqKoEg7vU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by MW5PR10MB5691.namprd10.prod.outlook.com (2603:10b6:303:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Tue, 3 Oct
 2023 15:32:10 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6792.024; Tue, 3 Oct 2023
 15:32:10 +0000
Message-ID: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
Date:   Tue, 3 Oct 2023 10:32:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: apply umask if POSIX ACL support is disabled
Content-Language: en-US
To:     Max Kellermann <max.kellermann@ionos.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net
References: <20230919081900.1096840-1-max.kellermann@ionos.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230919081900.1096840-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:610:20::43) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|MW5PR10MB5691:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d25adf-1463-47a3-1167-08dbc425e8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dkjmPolcGH9svYH5kmzoBYbYF3siRj3kUT8t11om61VuJ26JItGvxZKreNpYGP6oYB/J5W0tAfiiUqwSmLOKXbuyeu36hl7MwIs/BZr+azrfKzpr1bAGiRlbsMwdCfF5kme58CvaHqZ/YNtqoyeFj/2zmffzoWOcf8TBgvV4vsMplQHkB7JWLEHj59M/LgGYOPoSlZILIxApgwozJSSraV0QMIwwNi9VTejEPN0vQzyYKQ6pF3Icml8oHjfxUkQ29anyBHFDKIVaOzTUB4tDD2toebu/5GVdv6ONhlQxyU+vXK9VP7wppKxHGatFC+Q3BnbK3pgolcP8skIeWQ9KyQNZ6TmeCWqONyeRio9x8giclbIWKD86zfNjXSGObC35ttWRkDqVTHBnXuFWpNU20EMwf2XN5OrQ0yF9DeIkSox2Yg6WX/E5bPN3Ck0QoUhZh6cwYPItc4fhIGSSP29RbZpEq+YQK8pvNZmQgfNuwTJWznXEbEOa3UceNYrsmDPyN2Hncc7n743zdZQK4K7RMe8xRul/wTwzO0WPinG9zqFmnoznThI480/HHr240B9sX4Vdlq1k/m8ft/tF4gfwU1x1zzBvitb7UjBuDgGvHekYTwGJNRXj/hpRwmgoo2hE51pt4M8Vs1CiDV2UKLcQKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(26005)(6512007)(86362001)(31696002)(36756003)(38100700002)(66476007)(66556008)(478600001)(31686004)(316002)(2616005)(5660300002)(66946007)(44832011)(6486002)(8936002)(110136005)(4326008)(6506007)(41300700001)(8676002)(6666004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzRITkVUWkZyYTIxWml6clFNT2RzRGZRaEtQS3pndmRWMGkzcmdReHliUzU1?=
 =?utf-8?B?aDY1YWJiZEhrOGlqWG9HYXY0UVZCMlV5TXQwUGxMSk9ZT2gzRi9BOTlJRXJk?=
 =?utf-8?B?bUtLNnR4bkxlODZUMXkzWTJZMEQzVDlpMFlXTjdaMGxSdVBIaEoxaCs3ZGwy?=
 =?utf-8?B?YWtMc09Pa3Rad2dQWjltWmdDZUdNVzNoaW9SWUxsU3lWdFBLTXhRRlk0SFIz?=
 =?utf-8?B?MXdKcWNhV2NmVlBjSS9WaUNVQmJKN3BSM1RQeWp5eDJ3MVdkekg3S3UwRmtu?=
 =?utf-8?B?SUFab2tncDlzSjNkaWQvMHFBWGlrRVNmbkM3NzJSMVdyWWxHQTREdkZnemRD?=
 =?utf-8?B?V1lzQUNZVnU3ZDlEUklrd0JTUlJUeitpMzhueU5YVlJRK3lQeDB0T2ViWDBh?=
 =?utf-8?B?NFpTRXpmL2NDMEFrSnJhMjNqd2JoMHVtcENTbVp0MWJPZkhSRGQxRzVwU3JF?=
 =?utf-8?B?RTNjeDFGMm1qbTVKOVFyZ2plME1mQmo5SDhaK1hZdTFMS0s4YiswYVk0b0xM?=
 =?utf-8?B?ZEkwTHFudzFIeHRTeHFZcStzcE13cFh5SzhNWUl6RStmb1BwRUFtbGlxb2hu?=
 =?utf-8?B?OVM3OFM4VG04SWJ5R2xZM21DclVKczBjUDNLODdybEIxejFTaVk3SmkvbUhr?=
 =?utf-8?B?NFBUdzVIMGF3QW1WMll2NnhCR1BON0p6c0dTQjhHVFIwaVFxcTZNUnQzV1VJ?=
 =?utf-8?B?WjV3dXMzVGYraWFuM3AxaUd2QmhmY3BvUGc3dnJkYlg5bFQyTkVWcnFqS2hM?=
 =?utf-8?B?K1BTdGI3bkpDWitMaTJGZldLTFJDZTdmU1ZrcHY2Y01URlhXeDJtWXNaU3Jx?=
 =?utf-8?B?ZEVyZVFoN3FJRkhmLzFzY0dFK0k1eTliajh6NHFEL1pVR3VWYUpzbHVBbjVq?=
 =?utf-8?B?TXV3T0s1UnovYmxxbFh4cUF3U0UraE43QmFIbUsvSlV6dWk0MnEwL3VNZ0wx?=
 =?utf-8?B?MncyS2VuSTNDa1pOUVZGb0lrN2huckFSaXlqRTZFUWwzaVY1aWJhNS9rM0dF?=
 =?utf-8?B?K3N3WVBrWDlDNGpndGtFY2lJajg0UGMzc0ZXS2xCTFpvV0trajJNUXgyTHIr?=
 =?utf-8?B?cnRZdHpNQy8xc2FWSkZYcjZJd21sbVIvM1ZnaHdZRW9IdndhMUpNTVJYNDRl?=
 =?utf-8?B?TGQ5T1Z1N2ZtM0NRYWc4VXFzUHVqc2JCc3U2LzNTS29WTklaUm54VzR6bWlX?=
 =?utf-8?B?YjFudmlKaTN3N1ZpMjJrVW1qTUpZeWo5UUEzUVVnN3BTZnlEZXpZakJJeU4w?=
 =?utf-8?B?YnFFdlBHNkFsaS9JUW1nblNhUXlXS2piUlhoazNEL29zMHhFQ0ZtWm1SUmZz?=
 =?utf-8?B?dXE2Smt5Z3ZPRU5XUWo1VkluWU9pVm01QVJTaGl0c3lyVStyVmRWYWEyVDNP?=
 =?utf-8?B?dEgybVc5VFB6RXZRZEZxL1lwSzl6ZHRJdHlodDZ3b0lSS2J0VE4yeVc2c2Zz?=
 =?utf-8?B?N0xMSlE5cUhMc20yTFdCOHE5aVhTODVZU3EwRWNDQjE1SWg0MFZRMkpxOUZG?=
 =?utf-8?B?ck1DbEVRRkx4bEVkNXBCVm1DbG5aM0ZkdjRmKytNdGV5MWhhRHpDK1BrM2tT?=
 =?utf-8?B?OXV5eFhIdkVMU0xqdGMwc2ttM1F3U2Y1YjRwOXpHMXBpVXZhK2Jvb3BxOEFx?=
 =?utf-8?B?Q2ZJdWVxSld2b0p5TGh6bHFPWGFWOXROT3A1TEptblNQUnlEZTM0LzNqelpj?=
 =?utf-8?B?eXkvcDRmb0hmZUhQc0JoVWhEQzRoTHNlbW5uZERUTlRoQStyK1FtR09QSHFv?=
 =?utf-8?B?Q1E3ZmJEdUdKN3MwL081VXpOZUpwU0NKaE9UKzlBbkdSY1RHZDZFdWROa0Fs?=
 =?utf-8?B?YmdBbTFVQXlSZGNCejdxN3h2UWQ2RHhYRUV0QlJpVFdRTVBEUkpSSFRmcjQ0?=
 =?utf-8?B?eXNpRmxESXBaLzZTSlJCNjdwTWliaEJuOGdHY0VZTk5nYy9qenpKWkI4QWtz?=
 =?utf-8?B?cUpWekVXenZWMTNtZUIzOE01ZndseVI5T1loVmJBaWFWbHgzTUpmeUptYVBk?=
 =?utf-8?B?WS92R0k3YmNCQjhQSVdQRkphQlYwZ0RyRFRIcXNJaGZNaWdCTWVJcGRoRGhm?=
 =?utf-8?B?VHBmMno0RUdRSUUxR2FLSW5NRWVLdVY1TENuVDhldmFPSm9iRzJVczdqYS9u?=
 =?utf-8?B?cnRWVVkzQ3JWYVUvaDlIUjFoa2NUMm1rWHkvTTZrZDBOYXZlaVNDM2RKR0hN?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YXpLNkZDYmozaUlZTW05ODAzZHV6c2g3UkFLakhMYnRVTlh4QndmNnkxQ05V?=
 =?utf-8?B?Y2NneVZjUUV0TGJQN0dDRVBtYVhIWTVWbE1pVVpVK3NTL1plUDEzMkN2UHdF?=
 =?utf-8?B?RU9sV3UxdU9SeUxUTFhtNU5Gdjd3SUZiQkM4clRYTUZuVDB0aGhLZVloUlJM?=
 =?utf-8?B?SVVVMkd0a2xmaUtpeFYwc2dRWURiVVdqdEVCN3czVlE0VVlERDBuL1I2RmRa?=
 =?utf-8?B?VE9DMlNvWWFZNVFTVUpscXppQ0FTNkY3cHRXYmVNLy9ZM0ZLKzJsMGpldTM0?=
 =?utf-8?B?d0M3NXBjNVd1UVUyc2QyWTZlTHZNZGlDOFJ1MXRjL1JsanJqWWM0emtEQUZa?=
 =?utf-8?B?aysyMm9Hb3hva1hLb0psdVFvMG5iRmxXSkxnNEJxVGorL1NZOHNuN29yTm13?=
 =?utf-8?B?VGdTVjZWVVpoKzNsQklDOVJFSlFCT3NsVzNQcjZlMG9ZK0tYWWY1blJqWmNL?=
 =?utf-8?B?OWFXWmI4MHJobC9icDRUMlNwOFVnZWhCSzhLVHUzWUUwY0ZVbnBzaklhcW9x?=
 =?utf-8?B?Z3hWREJaZTA1MVpGaFEwQlRqTmZ5enVMVXM5TEJUQlMrN2cxeE4zeUsyc25C?=
 =?utf-8?B?WmUyVVpNOVpmajgvNTdlZ3V2TWNBYVZwSm04UTdDY3V6Q21kcVZyUHJkT1ll?=
 =?utf-8?B?UEJORHRTdGJ5VkVJN2hhSDhudjFMZHZBSDFMeHNOQk15N1ZkYldhdnlEdXk2?=
 =?utf-8?B?UzdVWjhuMXBVUGFLSXRBdEZwOVJadG8raHo5T3o3SzQzYkc3N3ZGYURDN0pZ?=
 =?utf-8?B?YXhiVWRrWWFtbHNEaExsb0tJZzRsZWRkNzJET3k3VGpLbkY5T2k4V0t3WTVG?=
 =?utf-8?B?RUZMMEVCZmZQQkErWncxOUhzd0RTNitwT3c1c2V1WTYrWnhDRzJwU3dQZUtN?=
 =?utf-8?B?aEZ3SGV5WGliKzVJTVRPRzlVR3hvMXZUUGVsTU8wYWhFa1lTVDQ3TUptNDQ3?=
 =?utf-8?B?Nmo2N3ZaUXF4K3M1QTk0bi9aL01kVVNjaWhrbHBEUXJiUXNJSUVmcFp4Zk9k?=
 =?utf-8?B?SGZoQ09NUGswVkxia3g0TnlnRXBJakp4SmtFRzk1ZHBDNTlYL013T2czVy80?=
 =?utf-8?B?U0tiUnY3SWlvM2JBOXFKLzRQc3BDNFFseFMyUXcvUDlVNkxjR1pjRWpxQ21j?=
 =?utf-8?B?YXI3RzdhMWNWeUczKzltYkUxdk1TTVlCMUlKTXl3REtocFNTc2hYTTBzVzRO?=
 =?utf-8?B?S21Ba3hBY0tJWDkvZTRWbllSR2tlV1RQWmVQMTQxM3dLTUJRbXhFZ2M1NHh5?=
 =?utf-8?B?ZGtodVNnQlJ4OExiRWRmcWtFS0hPdTlvcjd0Y1o3WTZ2Mzg1dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15d25adf-1463-47a3-1167-08dbc425e8ea
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 15:32:10.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPAzYSCwFzURUO4pp5z2QY2S4NAc03Kxo8qQt5Ni3xxcuP1boNHqB7n3IfHwl6TgYmvsjM+OscCw66F5Cliy/xAX9R8jp/BkeByPT47n5o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=701 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030116
X-Proofpoint-GUID: IVcy5QIRTvzRAKsNGbCHLqEbFuVZXQwb
X-Proofpoint-ORIG-GUID: IVcy5QIRTvzRAKsNGbCHLqEbFuVZXQwb
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I think this is sane, but the patch needs a description of why this is 
necessary for these specific file systems.

Thanks,
Shaggy

On 9/19/23 3:18AM, Max Kellermann wrote:
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>   fs/ceph/super.h           | 1 +
>   fs/ext2/acl.h             | 1 +
>   fs/jfs/jfs_acl.h          | 1 +
>   include/linux/posix_acl.h | 1 +
>   4 files changed, 4 insertions(+)
> 
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 51c7f2b14f6f..e7e2f264acf4 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1194,6 +1194,7 @@ static inline void ceph_forget_all_cached_acls(struct inode *inode)
>   static inline int ceph_pre_init_acls(struct inode *dir, umode_t *mode,
>   				     struct ceph_acl_sec_ctx *as_ctx)
>   {
> +	*mode &= ~current_umask();
>   	return 0;
>   }
>   static inline void ceph_init_inode_acls(struct inode *inode,
> diff --git a/fs/ext2/acl.h b/fs/ext2/acl.h
> index 4a8443a2b8ec..694af789c614 100644
> --- a/fs/ext2/acl.h
> +++ b/fs/ext2/acl.h
> @@ -67,6 +67,7 @@ extern int ext2_init_acl (struct inode *, struct inode *);
>   
>   static inline int ext2_init_acl (struct inode *inode, struct inode *dir)
>   {
> +	inode->i_mode &= ~current_umask();
>   	return 0;
>   }
>   #endif
> diff --git a/fs/jfs/jfs_acl.h b/fs/jfs/jfs_acl.h
> index f892e54d0fcd..10791e97a46f 100644
> --- a/fs/jfs/jfs_acl.h
> +++ b/fs/jfs/jfs_acl.h
> @@ -17,6 +17,7 @@ int jfs_init_acl(tid_t, struct inode *, struct inode *);
>   static inline int jfs_init_acl(tid_t tid, struct inode *inode,
>   			       struct inode *dir)
>   {
> +	inode->i_mode &= ~current_umask();
>   	return 0;
>   }
>   
> diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
> index 0e65b3d634d9..54bc9b1061ca 100644
> --- a/include/linux/posix_acl.h
> +++ b/include/linux/posix_acl.h
> @@ -128,6 +128,7 @@ static inline void cache_no_acl(struct inode *inode)
>   static inline int posix_acl_create(struct inode *inode, umode_t *mode,
>   		struct posix_acl **default_acl, struct posix_acl **acl)
>   {
> +	*mode &= ~current_umask();
>   	*default_acl = *acl = NULL;
>   	return 0;
>   }
