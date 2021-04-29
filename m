Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4D36E84E
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Apr 2021 12:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239984AbhD2KCu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Apr 2021 06:02:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbhD2KCu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Apr 2021 06:02:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T9tSj9163247;
        Thu, 29 Apr 2021 10:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SdHbvTMwRiTYMrSalUa+GQloCuPqi51NOzSJRFny5Ak=;
 b=nA6P5pHQQVD82DC8Xoc3J7QlKhMltgmQCWT+VmCelBY8Ho8FS4pkyzyeixULm2laZi1h
 NO4vFB3Q0XD1F/3HjRMouweoFNNDWB8Upk1oTy72z7QEg+pqFc4IKBXciENKIZWnqTJ8
 6pVNC63VYBDD5Dn2RB8X1x0wYuu+jo6JoxxCAxVFumJfzdhBIC+k/4qtlHBjZ3G8Ku+6
 SdtlfAwkYdjKii4kSlOAr1iMUOP0flqZxJtuHaKrtL3spwx4V6CaZ+wezo6W8FXFoXVn
 aZRRWSleGCAUxVtXOumknsQr0AKm9jHxi+wk31nbTbtShf17cZpXuMxxBSULDGX0h8Lo 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 385aft3srp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 10:01:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T9ttsQ124545;
        Thu, 29 Apr 2021 10:01:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 384b5a1tqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 10:01:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iDb9Zr8dLM0zya56N8DjUlGxpUIVeOD+PWprwoX8K/xQyN7vcShTFbRjQRE7cr1jwLgUzyFxozqByKjz5XhvHj871DLPfNPh3KVVukGKnfjQmELExP51QckxjAw+f2HHrdPpyAs6cprWrRxqMUT0+O00MKUW6b3PSx3zA6PCt57fPm+ULsKso15N06UrlSIsz158zj/Kv+QlUdNF7JeaFW9GpCpQ6899WxoNLfW/32lTjMAbpDlg73eF4np9NOPzhQXQ+g+N4jS/nLOlNaA+W3WCM4WdQKjffOf35SfkIm1OMUB4b8pWBEamTXIa3mEkRCKFjhGmO/+XFPdLO4ohWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdHbvTMwRiTYMrSalUa+GQloCuPqi51NOzSJRFny5Ak=;
 b=Dg4P6ySbsYuFwkm9FUU/0aRzi3vd2SIVpzCXi5rYisCO/pUC+U3G8EFwJZslKFMiNV6xnW6gKWBB5AzEFJwW5Z0TV+qgdVyGk5PrSK3ONvMGd7SvF3a3k9wM485Vx6iQzXoUtHo+4xfqeNsFpfeeBkN9hZHgn2QWMiDqDfUtuftHC753nuuwXi7qsttkY8vygEI2LCOzEUKDN9/0/oaqBRUiUaje5J9NOdX9xJjZy8znb/OzEnZhU/9WVKcE2uuJ/K0+cZGX0d1JH/8YsDj98OzyfNoF/tjtA0j1MqB0wwUUSf2jcQU4xdRQ8OLCKTcthGv0uQkRj0z1Bqjqc8jSHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdHbvTMwRiTYMrSalUa+GQloCuPqi51NOzSJRFny5Ak=;
 b=wEFw8iBhaAuHDBI4Lf3fUof7h26ONhEMkjMhN+AB9bg9hZHOdzE/tkhaFTjS5hjQ/AdjVZeNIfGZylPa8Tn2R5p7gBUVr3kfIFMMw79PI0Rc5l8wFP2R2Inyomw89SfIt3fRD1sTPuCY1BHQYySrdmN40ZcXxZ+FMclnM0Zk+C0=
Authentication-Results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=oracle.com;
Received: from CY4PR1001MB2133.namprd10.prod.outlook.com
 (2603:10b6:910:43::27) by CY4PR1001MB2408.namprd10.prod.outlook.com
 (2603:10b6:910:4a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 10:01:54 +0000
Received: from CY4PR1001MB2133.namprd10.prod.outlook.com
 ([fe80::40a:b796:4a86:d0cc]) by CY4PR1001MB2133.namprd10.prod.outlook.com
 ([fe80::40a:b796:4a86:d0cc%3]) with mapi id 15.20.4065.029; Thu, 29 Apr 2021
 10:01:54 +0000
Subject: Re: [PATCH] ext4: fix memory leak in ext4_fill_super
To:     Pavel Skripkin <paskripkin@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
References: <20210428172828.12589-1-paskripkin@gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <3c3877a4-fef2-9e24-f99f-2ecc46deb7e4@oracle.com>
Date:   Thu, 29 Apr 2021 12:01:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210428172828.12589-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [86.217.245.67]
X-ClientProxiedBy: MR2P264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:1::21) To CY4PR1001MB2133.namprd10.prod.outlook.com
 (2603:10b6:910:43::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.13] (86.217.245.67) by MR2P264CA0009.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500:1::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 10:01:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb0bff1a-d337-4c04-38cd-08d90af5d13c
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2408:
X-Microsoft-Antispam-PRVS: <CY4PR1001MB24083CA26314FD9719F7F55D975F9@CY4PR1001MB2408.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QCXFQueQ+Z/VK61W0MAHId+7AqEeKI3cPc1dqryphQT99gFOQPPx+IZeGTZTdcxn0ijAHjsIqXx853LwkregXEgfvrQBZJQ8oIwkqC2U9kxANSQe/VasSNVgLj3rEHwpUZJq4ELdpAoZA3RPYnlNwjLiDbKgAlZZsjKdyikyvvD+96bX0yplvpDSUvxAzRcx1K7QElJSxC3il02IUWuCqJbm1JPyA1ehJ8OgITx++1UUxaOjYC4mSELgJcmhSnO5GNBzKeRKroRGam55gFyb391hnvyz/nKcrx0b8ukEAS+3IkvL38tStk6O5vV+7QIP9bLmwJx5hEnSnDOTkJTALwnu2FXLJec+U6TTmMeZaCGgnXVrNcjRgtmXEnbq1Gs23sLmL7xIwgLgdjQ72exPG4tlM5zn5XsMf8fowYowboXSDAjtQXiy5aOL8pBRU5+70mo8ZQq/VPv3YOtkdXwp4wOOSSqDcQZxTqkahqjd3BtGO9pYt94Irm592Y8UtMziFAzymgObXCMmrQ1egq8iM7dGnlV4zH+ZxwLSVUCq+X4QMT+Ut07GnLALBcBdaglyOnbtvVP8R7S45lgtWDHWrNMyZAvJPTJY0XCgr1zFf7s1uEMU3LYHoSHRIwlRPCVmEm42URtZ/3ICLC7hxIV5V6K8jWyya2l0TB5iFOyzWJs+ruwp24DZwB80nDphuifBVPF2w/KbGrJWDtSB5JTIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2133.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(346002)(136003)(396003)(366004)(6486002)(53546011)(66556008)(6666004)(26005)(44832011)(38100700002)(31686004)(16526019)(956004)(2906002)(316002)(478600001)(16576012)(2616005)(31696002)(186003)(66946007)(86362001)(83380400001)(4326008)(5660300002)(38350700002)(52116002)(8936002)(8676002)(66476007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dW0rU2ZqaEZaeERQanFQTTAxQzlsZ0UydTBWR3YreHFkSGpzWDhIQ2xyVFVo?=
 =?utf-8?B?eHJ5R01oYzhLd3JHT1FOTysxQjkwOXRvQ1B6L3pKZTA5K3lJK2dtbWRjbHZP?=
 =?utf-8?B?SGs2R1hLSENTREx3ZXEyaURZbEh5ZGdPTjZCU3ljT01jbHlkT00ybmRhS0NH?=
 =?utf-8?B?QXl4MFYvNTJIMklPdFJueEpzTkhKVy84N21janNMRWdyYnpwV2RjeTZHSGtz?=
 =?utf-8?B?d2lEN002RjNlcWo3dWRkUVF2bys1VHozb21KUVZIa2JiSUdidDZUUHEzOVYy?=
 =?utf-8?B?QjlxazQveXNZc3J1NjJ6VHdVRnQvdCtqMmhFNW9ZMFh4M1drOW12MkN1THhT?=
 =?utf-8?B?RVNyUWFwOTNWanNBbmlzQSszeHk3aXV0ZmpJRGU0Q2JqNzFMQnFjK0FGNWRx?=
 =?utf-8?B?dVRVNlBKZ1o2Y3hWWUhKSUliMFptWW1MZ3FPb0x3Q3BXbzlBMCtPZTVPTDR5?=
 =?utf-8?B?QmgzQkhWOHZNU0FFTFJ3TUYyNFhMSStmVDE2cVJjblY4SWM3MHU0ZlJBNm5R?=
 =?utf-8?B?WXBMUzRNb0FCcEV1a3dZWlZXWkZaaEptWDhUbDdOSDdiVzVrdm5TRzFJMytn?=
 =?utf-8?B?cmhLazN2RUJ5ekZrNEdOekFsMzhhekRXbmN5QndTTDN4VzljYzAyYXZoVGN1?=
 =?utf-8?B?dDdJYXZ6eDdlSFdKNTVOU0dDdGhGYWhYM2RkNHJQSHZDVjhLRTVzaTBjbjR5?=
 =?utf-8?B?K1Zzc1VvYkpwM2dJZlFvZU5aT1Q3QlV0V2JubkdpSE9VTlBTRkxtSHJPekFJ?=
 =?utf-8?B?d2dyZUgyTTlCUDY5Q05mNFlqYlVvdmJ4S1lGSm1CcStKeWVJMlR2bzFWRXpU?=
 =?utf-8?B?Z0V1T2dNTHBkRHVHRWoxQWM1Rm9LV0c4YVFVSTBRUXR5dTllRjM2NkNGRlZu?=
 =?utf-8?B?N09naDhqTlcvNWp3RGpGYW51QjVvQkxjTC96ZUo2am1SY0ZLc2dKdFYzaGhR?=
 =?utf-8?B?UGh3b0VIaU1lYU5hcUxQTzYxWXR6OWRxdDFEWG5xbUJSaVNXWVg3QlR2N2NZ?=
 =?utf-8?B?bjZkU3RHU0xOQ05EUFpEdE43QW0zUEc4MVFqRkNOVlM1QXk5dmRvUEluN1Jw?=
 =?utf-8?B?M1U2aDcxRUNja0NkOWpaK0crUmJCS1RaV1VuY0prTWQyMDR5bWJYd0s2L0J5?=
 =?utf-8?B?R29kYmMvL0FWWDdOTnkyWCtnYVNsZFp5Tm1wM1dHV2NYQWxNSjI2cnZ2L0NP?=
 =?utf-8?B?UzFITzFka2tud3pRcVRhbjlldkY0ejVsRndmWVFrU2sxNHRFcVpZQnlUT0Rl?=
 =?utf-8?B?Skh4ZGY2WjdicStvMURkYjRTRmpkNW5ENW92b3NXMUMxc0I0ZWpvVzZkdElP?=
 =?utf-8?B?Ykp0WXoxSDlPZ0pXYWprTmFhTkNYa2kwOFB6RkxxeC80bU5BaERwRmZ5c3p2?=
 =?utf-8?B?NVBSZVlGTnlMU1pDeFJQUHRXZVkwWVBlSkIzTWVzc1JtRzcvRlpVTzlkT2xW?=
 =?utf-8?B?bGp0bWJ3Vm1PZGk4TWZadjhuNjR4aFplWUdDa1gvdy9XdTBFTEFrWGM2Nndn?=
 =?utf-8?B?QlhmV21mbE1qcVpjOEFscG84bm54ZU5zQ0puRm5jRHlFR0ZhYTJQUkdXK2tW?=
 =?utf-8?B?T3hsejlUOHFJS0w1L0ExVDRESFp0YWhkS0U0ajFnWkc5eXpXaCtYUUZFS3Rq?=
 =?utf-8?B?U3lsNVRRa0RTTi9IQjE3WmJoZ3VCQk9zNzdwd3JEcnhHc3ZYMWhmdlRNTFhm?=
 =?utf-8?B?QnlHNnRNaVc1UjJjL2RBYW1IRTlOUWdKWWdIdElUcElhYmovRmpTTjh6eFNS?=
 =?utf-8?Q?zzd08c8EMEfFZsFsXN0SYHiBca8qI8CpJ0IeyyL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0bff1a-d337-4c04-38cd-08d90af5d13c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2133.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:01:54.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MK2D/JmXFJVwYIkVAKdhvY75z3Y8kWeXxg8cddJuiQhA0GaX7pLrrYJt7SpbltAnTYD5ogx3ftTjALiwCqyk06e2TkqE2nZ46pfBQRvU5Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2408
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290068
X-Proofpoint-GUID: JWNySiywdjU6SdH10-wCCYejI8uMbwtg
X-Proofpoint-ORIG-GUID: JWNySiywdjU6SdH10-wCCYejI8uMbwtg
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290068
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2021-04-28 19:28, Pavel Skripkin wrote:
> syzbot reported memory leak in ext4 subsyetem.
> The problem appears, when thread_stop() call happens
> before wake_up_process().
> 
> Normally, this data will be freed by
> created thread, but if kthread_stop()
> returned -EINTR, this data should be freed manually
> 
> Reported-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
> Tested-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>   fs/ext4/super.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b9693680463a..9c33e97bd5c5 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5156,8 +5156,10 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>   failed_mount3:
>   	flush_work(&sbi->s_error_work);
>   	del_timer_sync(&sbi->s_err_report);
> -	if (sbi->s_mmp_tsk)
> -		kthread_stop(sbi->s_mmp_tsk);
> +	if (sbi->s_mmp_tsk) {
> +		if (kthread_stop(sbi->s_mmp_tsk) == -EINTR)
> +			kfree(kthread_data(sbi->s_mmp_tsk));
> +	}
>   failed_mount2:
>   	rcu_read_lock();
>   	group_desc = rcu_dereference(sbi->s_group_desc);
> 

So I've looked at this, and the puzzling thing is that ext4 uses
kthread_run() which immediately calls wake_up_process() -- according to
the kerneldoc for kthread_stop(), it shouldn't return -EINTR in this
case:

  * Returns the result of threadfn(), or %-EINTR if wake_up_process()
  * was never called.
  */
int kthread_stop(struct task_struct *k)

So it really looks like kthread_stop() can return -EINTR even when
wake_up_process() has been called but the thread hasn't had a chance to
run yet?

If this is true, then we either have to fix kthread_create() to make
sure it respects the behaviour that is claimed by the comment OR we have
to audit every single kthread_stop() in the kernel which does not check
for -EINTR.


Vegard
